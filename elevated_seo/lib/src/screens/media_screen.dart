import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevated_seo/src/model/media_model.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/functions.dart';
import 'package:elevated_seo/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MediaScreen extends StatefulWidget {
  final bool isHomeScreen;

  const MediaScreen({Key key, this.isHomeScreen = false}) : super(key: key);

  @override
  _MediaScreenState createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  @override
  Widget build(BuildContext context) {
    changeStatusColor(primaryColor);

    return Consumer<ApplicationState>(
      builder: (context, value, child) {
        if (value.mediasList.isEmpty)
          return Center(child: CircularProgressIndicator());

        return ListView.builder(
          itemCount: value.mediasList.length,
          padding: EdgeInsets.symmetric(vertical: 10),
          itemBuilder: (context, index) {
            GMBMedia media = value.mediasList[index];

            return Material(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: media.googleUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            media.description ?? "",
                            style: TextStyle(
                              color: textColorPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.eye,
                                color: Colors.black,
                                size: 15.0,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                media.insights['viewCount'] ?? "0",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
