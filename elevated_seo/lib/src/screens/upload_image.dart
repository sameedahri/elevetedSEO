import 'dart:io';
import 'dart:typed_data';
import 'package:elevated_seo/src/model/media_model.dart';
import 'package:elevated_seo/src/model/posts_model.dart';
import 'package:elevated_seo/src/screens/home_page.dart';
import 'package:elevated_seo/src/services/api_services.dart';
import 'package:elevated_seo/src/services/storage_services.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/functions.dart';
import 'package:elevated_seo/src/utils/route.dart';
import 'package:elevated_seo/src/utils/utils.dart';
import 'package:elevated_seo/src/utils/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class UploadImage extends StatefulWidget {
  final String filePath;

  const UploadImage({Key key, @required this.filePath}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _postKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _mediaKey = GlobalKey<FormState>();
  String title, keywords, actionButton;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  String getActionType() {
    String val = actionButton;
    if (val.contains("Book"))
      return "BOOK";
    else if (val.contains("Order Online"))
      return "ORDER";
    else if (val.contains("Buy"))
      return "SHOP";
    else if (val.contains("Learn more"))
      return "LEARN_MORE";
    else if (val.contains("Sign up"))
      return "SIGN_UP";
    else
      return "";
  }

  submitForm() async {
    if (tabController.index == 0) {
      if (_postKey.currentState.validate())
        _postKey.currentState.save();
      else
        return;
    } else {
      if (_mediaKey.currentState.validate())
        _mediaKey.currentState.save();
      else
        return;
    }

    ApplicationState state =
        Provider.of<ApplicationState>(context, listen: false);

    try {
      Uint8List uint8list = await compressFile(File(widget.filePath));

      UploadTask uploadTask = FirebaseStorage.instance
          .ref("images")
          .child(
              '${state.gmbUser.uid}${DateTime.now().microsecondsSinceEpoch}.jpg')
          .putData(uint8list);

      uploadTask.snapshotEvents.listen((event) {
        EasyLoading.showProgress(
            event.bytesTransferred.toDouble() / event.totalBytes.toDouble(),
            status: "Please Wait..");
      });

      uploadTask.snapshotEvents.listen((event) async {
        if (event.state == TaskState.success) {
          EasyLoading.dismiss();

          if (tabController.index == 0) {
            GMBPosts gmbPosts = GMBPosts(
              summary: title,
              languageCode: "en-US",
              callToAction: {"actionType": getActionType(), "url": keywords},
              media: [
                {
                  "googleUrl": await uploadTask.snapshot.ref.getDownloadURL(),
                  "mediaFormat": "PHOTO",
                }
              ],
            );

            ApiService(authHeaders: state.authHeaders)
                .postPost(
                    state.gmbUser.accountNumber,
                    state.locationList[state.locationIndex].name
                        .split("/")
                        .last,
                    gmbPosts)
                .then((value) {
              if (value.containsKey("error")) {
                EasyLoading.showError(value['error']['message']);
              } else {
                EasyLoading.showSuccess("Success!");
              }
              MyRoute.push(context, HomePage(), replaced: true);
            });
          } else {
            GMBMedia media = GMBMedia(
              description: title,
              locationAssociation: {"category": "ADDITIONAL"},
              mediaFormat: "PHOTO",
              sourceUrl: await uploadTask.snapshot.ref.getDownloadURL(),
            );
            ApiService(authHeaders: state.authHeaders)
                .postMedia(
                    state.gmbUser.accountNumber,
                    state.locationList[state.locationIndex].name
                        .split("/")
                        .last,
                    media)
                .then((value) {
              Provider.of<ApplicationState>(context, listen: false)
                  .getMedia(force: true);
              EasyLoading.showSuccess("Success!");
              MyRoute.push(context, HomePage(), replaced: true);
            });
          }
        }
      });
    } catch (e, t) {
      EasyLoading.showError("Error: $e");
      print(t);
    }
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.white);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomSheet: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    if (tabController.index == 0)
                      _postKey.currentState.reset();
                    else
                      _mediaKey.currentState.reset();
                  },
                  child: Text(
                    "Reset",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
                MaterialButton(
                  onPressed: () => submitForm(),
                  child: Text("Create Post"),
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.white,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: TabBar(
                      controller: tabController,
                      indicatorColor: primaryColor,
                      indicatorWeight: 4.0,
                      tabs: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Post",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Photo",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 35.0),
                child: Form(
                  key: _postKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(widget.filePath),
                            width: width(context),
                            height: MediaQuery.of(context).size.height * 0.3,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      addVerticalLine(16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Add a title",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        onSaved: (val) => title = val,
                        validator: (val) =>
                            val.isEmpty ? "This field is required." : null,
                      ),
                      addVerticalLine(16.0),
                      DropdownButtonFormField(
                        onChanged: (val) => actionButton = val,
                        onSaved: (val) => actionButton = val,
                        decoration: InputDecoration(
                          labelText: "Choose action type",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (val) => actionButton == null
                            ? "This field is required."
                            : null,
                        items: [
                          "Book",
                          "Order Online",
                          "Buy",
                          "Learn more",
                          "Sign up"
                        ]
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ),
                            )
                            .toList(),
                      ),
                      addVerticalLine(16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Add a website link",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        onSaved: (val) => keywords = val,
                        keyboardType: TextInputType.url,
                        validator: (val) => val.isEmpty
                            ? tabController.index == 0
                                ? !val.startsWith("http")
                                    ? "Please enter a valid url"
                                    : null
                                : "This field is required."
                            : null,
                      ),
                      addVerticalLine(50.0),
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 35.0),
                child: Form(
                  key: _mediaKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(widget.filePath),
                            width: width(context),
                            height: MediaQuery.of(context).size.height * 0.30,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      addVerticalLine(16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Title",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        onSaved: (val) => title = val,
                        validator: (val) =>
                            val.isEmpty ? "This field is required." : null,
                      ),
                      addVerticalLine(16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Keywords",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        onSaved: (val) => keywords = val,
                        textCapitalization: TextCapitalization.words,
                        validator: (val) =>
                            val.isEmpty ? "This field is required." : null,
                      ),
                      addVerticalLine(50.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
