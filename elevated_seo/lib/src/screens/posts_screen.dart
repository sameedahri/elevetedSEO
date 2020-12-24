import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevated_seo/src/model/posts_model.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    changeStatusColor(primaryColor);

    return Consumer<ApplicationState>(
      builder: (context, value, child) {
        if (value.postsList.isEmpty)
          return Center(child: CircularProgressIndicator());

        return ListView.builder(
          itemCount: value.postsList.length,
          padding: EdgeInsets.symmetric(vertical: 10),
          itemBuilder: (context, index) {
            GMBPosts gmbPosts = value.postsList[index];

            return ShowPost(gmbPosts: gmbPosts);
          },
        );
      },
    );
  }
}

class ShowPost extends StatelessWidget {
  final GMBPosts gmbPosts;

  const ShowPost({Key key, @required this.gmbPosts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Hero(
                tag: gmbPosts.name,
                child: CachedNetworkImage(
                  imageUrl: gmbPosts.media[0]['googleUrl'],
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              gmbPosts.summary,
              style: TextStyle(
                color: textColorPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getDateString(gmbPosts.createTime)),
                MaterialButton(
                  child: Text(
                    gmbPosts.callToAction['actionType'],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  onPressed: () => launch(gmbPosts.callToAction['url']),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
