import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevated_seo/src/model/media_model.dart';
import 'package:elevated_seo/src/model/posts_model.dart';
import 'package:elevated_seo/src/screens/components/empty_home_data.dart';
import 'package:elevated_seo/src/screens/components/full_screen_image.dart';
import 'package:elevated_seo/src/screens/components/header_home.dart';
import 'package:elevated_seo/src/screens/components/image_chooser.dart';
import 'package:elevated_seo/src/screens/components/single_post_screen.dart';
import 'package:elevated_seo/src/screens/media_screen.dart';
import 'package:elevated_seo/src/screens/posts_screen.dart';
import 'package:elevated_seo/src/screens/review_screen.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/functions.dart';
import 'package:elevated_seo/src/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LatestPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderImage(
              title: "Recent Posts",
              subtitle: "Posts",
              isListEmpty: Provider.of<ApplicationState>(context, listen: false)
                  .postsList
                  .isEmpty,
            ),
            addVerticalLine(10.0),
            Consumer<ApplicationState>(
              builder: (context, value, child) {
                if (value.postsList.isEmpty) {
                  return EmptyHomeData(
                    title: "posts",
                    buttonText: "Create New Post",
                    onTap: () => chooseImage(context),
                  );
                }

                return Container(
                  margin: EdgeInsets.only(left: 24.0, right: 24.0),
                  height: size.height * 0.25,
                  child: ListView.builder(
                    itemCount: getItemCount(value.postsList.length),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      GMBPosts gmbPosts = value.postsList[index];

                      return Material(
                        // color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) =>
                                      SinglePostScreen(gmbPosts: gmbPosts),
                                ),
                              ),
                              child: Container(
                                height: size.height * 0.18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Hero(
                                    tag: gmbPosts.name,
                                    child: CachedNetworkImage(
                                      imageUrl: gmbPosts.media[0]['googleUrl'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            MaterialButton(
                              child: Text(
                                gmbPosts.callToAction['actionType']
                                    .replaceAll("_", " "),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                              height: 25.0,
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              onPressed: () =>
                                  launch(gmbPosts.callToAction['url']),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            addVerticalLine(20.0),
            HeaderImage(
              title: "Recent Photos",
              subtitle: "Photos",
              isListEmpty: Provider.of<ApplicationState>(context, listen: false)
                  .mediasList
                  .isEmpty,
            ),
            addVerticalLine(10.0),
            Consumer<ApplicationState>(
              builder: (context, value, child) {
                if (value.mediasList.isEmpty) {
                  return EmptyHomeData(
                    title: "photos",
                    buttonText: "Upload Photo",
                    onTap: () => chooseImage(context),
                  );
                }

                return Container(
                  margin: EdgeInsets.only(left: 24.0, right: 24.0),
                  height: size.height * 0.25,
                  child: ListView.builder(
                    itemCount: getItemCount(value.mediasList.length),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      GMBMedia gmbMedia = value.mediasList[index];

                      return Padding(
                        padding: index != 0
                            ? const EdgeInsets.only(left: 15)
                            : EdgeInsets.zero,
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => FullImage(
                                    gmbMedia: gmbMedia,
                                  ),
                                ),
                              ),
                              child: Hero(
                                tag: gmbMedia.name,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: gmbMedia.googleUrl,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.eye,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    gmbMedia.insights['viewCount'] ?? "0",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            addVerticalLine(20.0),
            HeaderImage(
              title: "Recent Reviews",
              subtitle: "Reviews",
              isListEmpty: Provider.of<ApplicationState>(context, listen: false)
                  .reviewsList
                  .isEmpty,
            ),
            addVerticalLine(10.0),
            Consumer<ApplicationState>(
              builder: (context, value, child) {
                if (value.reviewsList.isEmpty) {
                  return Material(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "You don't have any reviews.",
                          style: TextStyle(
                            color: textColorPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return Container(
                  width: size.width,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: ReviewScreen(
                    isHomeScreen: true,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SeeAll extends StatefulWidget {
  final String title;

  const SeeAll({Key key, @required this.title}) : super(key: key);

  @override
  _SeeAllState createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: getWidget(),
    );
  }

  Widget getWidget() {
    if (widget.title == "Reviews") {
      return ReviewScreen();
    } else if (widget.title == "Photos") {
      return MediaScreen();
    } else {
      return PostsScreen();
    }
  }
}
