import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevated_seo/src/model/media_model.dart';
import 'package:elevated_seo/src/services/api_services.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FullImage extends StatelessWidget {
  final GMBMedia gmbMedia;

  const FullImage({Key key, this.gmbMedia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.white);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomSheet: Container(
        height: 55,
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.eye,
                  color: Colors.black,
                  size: 15.0,
                ),
                SizedBox(width: 5.0),
                Text(
                  gmbMedia.insights['viewCount'] ?? "0",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            MaterialButton(
              onPressed: () async {
                OkCancelResult result = await showOkCancelAlertDialog(
                  context: context,
                  okLabel: "Yes",
                  barrierDismissible: false,
                  title: "Delete",
                  message: "Do you really want to delete this photo?",
                );

                if (result == OkCancelResult.ok) delete(context, gmbMedia);
              },
              child: Text("Delete Photo"),
              textColor: Colors.black,
            )
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Hero(
          tag: gmbMedia.name,
          child: CachedNetworkImage(
            imageUrl: gmbMedia.googleUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  delete(BuildContext context, GMBMedia gmbMedia) async {
    Map<String, String> headers =
        Provider.of<ApplicationState>(context, listen: false).authHeaders;

    final result =
        await ApiService(authHeaders: headers).deleteMedia(gmbMedia.name);

    if (result.isNotEmpty) {
      EasyLoading.showSuccess("Success!");
      Provider.of<ApplicationState>(context, listen: false)
          .getMedia(force: true);
      Navigator.pop(context);
    }
  }
}
