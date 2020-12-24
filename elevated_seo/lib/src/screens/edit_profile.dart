import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevated_seo/src/model/media_model.dart';
import 'package:elevated_seo/src/screens/components/image_chooser.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/functions.dart';
import 'package:elevated_seo/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    changeStatusColor(layoutBackgroundWhite);

    return Consumer<ApplicationState>(
      builder: (context, value, child) {
        String profileUrl, coverUrl;
        value.mediasList.forEach((m) {
          if (m.locationAssociation['category'] == "PROFILE")
            profileUrl = m.googleUrl;
          if (m.locationAssociation['category'] == "COVER")
            coverUrl = m.googleUrl;
        });

        return Scaffold(
          backgroundColor: layoutBackgroundWhite,
          body: Container(
            child: Column(
              children: <Widget>[
                AppBar(
                  backgroundColor: layoutBackgroundWhite,
                  elevation: 0.0,
                  leading: IconButton(
                    icon: FaIcon(FontAwesomeIcons.arrowLeft),
                    onPressed: () => Navigator.pop(context),
                  ),
                  centerTitle: true,
                  title: Text(
                    "Edit Profile",
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      decoration: boxDecoration(radius: 8, showShadow: true),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: <Widget>[
                            InkWell(
                              onTap: () =>
                                  chooseImage(context, coverImage: GMBMedia()),
                              child: coverUrl != null
                                  ? CachedNetworkImage(
                                      imageUrl: coverUrl,
                                      height: height * 0.25,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      "assets/images/1.png",
                                      height: height * 0.25,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                            Positioned(
                              top: height * 0.225,
                              right: 10,
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: height * 0.20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    SizedBox(width: 10),
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Stack(
                                        children: [
                                          InkWell(
                                            onTap: () => chooseImage(context,
                                                profileImage: GMBMedia()),
                                            child: CircleAvatar(
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                profileUrl != null
                                                    ? profileUrl
                                                    : "https:" +
                                                        value.gmbUser
                                                            .profilePhotoUrl,
                                              ),
                                              radius: width * 0.13,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(2.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: primaryColor,
                                              ),
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 15.0,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          value.gmbUser.accountName,
                                          style: TextStyle(
                                            color: textColorPrimary,
                                            fontWeight: FontWeight.w700,
                                            fontSize: textSizeLargeMedium,
                                          ),
                                        ),
                                        Text(
                                          value.gmbUser.locations['locations']
                                                  [0]['primaryCategory']
                                              ['displayName'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.0,
                                          ),
                                          overflow: TextOverflow.clip,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 24),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getItem(String name) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 16,
                  ),
                  text(name, textColor: textColorPrimary)
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.keyboard_arrow_right),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: divider(),
        )
      ],
    );
  }
}
