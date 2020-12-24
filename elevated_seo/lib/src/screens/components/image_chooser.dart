import 'dart:io';
import 'dart:typed_data';

import 'package:elevated_seo/src/model/media_model.dart';
import 'package:elevated_seo/src/screens/upload_image.dart';
import 'package:elevated_seo/src/services/api_services.dart';
import 'package:elevated_seo/src/services/image_service.dart';
import 'package:elevated_seo/src/services/storage_services.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

chooseImage(BuildContext context,
    {GMBMedia profileImage, GMBMedia coverImage}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            width: 50,
            height: 10,
            decoration:
                boxDecoration(color: viewColor, radius: 16, bgColor: viewColor),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.width * 0.45,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    addVerticalLine(10.0),
                    ListTile(
                      onTap: () async {
                        String data = await pickImage(ImageSource.camera);
                        if (data != "Error") {
                          Navigator.pop(context);
                          ApplicationState state =
                              Provider.of<ApplicationState>(context,
                                  listen: false);
                          if (profileImage != null)
                            uploadNewProfile(context, data, true, state);
                          else if (coverImage != null)
                            uploadNewProfile(context, data, false, state);
                          else
                            MyRoute.push(
                              context,
                              UploadImage(filePath: data),
                            );
                        }
                      },
                      leading: Icon(
                        Icons.camera,
                        color: textColorPrimary,
                        size: 30,
                      ),
                      title: Text(
                        "Camera",
                        style: TextStyle(color: textColorPrimary),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        String data = await pickImage(ImageSource.gallery);
                        if (data != "Error") {
                          ApplicationState state =
                              Provider.of<ApplicationState>(context,
                                  listen: false);
                          Navigator.pop(context);
                          if (profileImage != null)
                            uploadNewProfile(context, data, true, state);
                          else if (coverImage != null)
                            uploadNewProfile(context, data, false, state);
                          else
                            MyRoute.push(
                              context,
                              UploadImage(filePath: data),
                            );
                        }
                      },
                      leading: Icon(
                        Icons.image,
                        color: textColorPrimary,
                        size: 30,
                      ),
                      title: Text(
                        "Gallery",
                        style: TextStyle(color: textColorPrimary),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      );
    },
  );
}

uploadNewProfile(BuildContext context, String filePath, bool isProfile,
    ApplicationState state) async {
  Uint8List uint8list = await compressFile(File(filePath));

  UploadTask uploadTask = FirebaseStorage.instance
      .ref("images")
      .child('${state.gmbUser.uid}${DateTime.now().microsecondsSinceEpoch}.jpg')
      .putData(uint8list);

  uploadTask.snapshotEvents.listen((event) {
    EasyLoading.showProgress(
        event.bytesTransferred.toDouble() / event.totalBytes.toDouble(),
        status: "Please Wait..");
  });

  uploadTask.snapshotEvents.listen(
    (event) async {
      if (event.state == TaskState.success) {
        EasyLoading.dismiss();

        ApiService(authHeaders: state.authHeaders)
            .postMedia(
              state.gmbUser.accountNumber,
              state.gmbUser.locations['locations'][0]["name"].split("/").last,
              GMBMedia(
                mediaFormat: "PHOTO",
                locationAssociation: {
                  "category": isProfile ? "PROFILE" : "COVER"
                },
                sourceUrl: await uploadTask.snapshot.ref.getDownloadURL(),
              ),
            )
            .then(
              (value) => EasyLoading.showSuccess("Success!"),
            );
      }
    },
  );
}
