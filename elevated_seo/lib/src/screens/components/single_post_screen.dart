import 'package:elevated_seo/src/model/posts_model.dart';
import 'package:elevated_seo/src/screens/posts_screen.dart';
import 'package:elevated_seo/src/utils/functions.dart';
import 'package:flutter/material.dart';

class SinglePostScreen extends StatelessWidget {
  final GMBPosts gmbPosts;

  const SinglePostScreen({Key key, this.gmbPosts}) : super(key: key);

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
      body: ShowPost(gmbPosts: gmbPosts),
    );
  }
}
