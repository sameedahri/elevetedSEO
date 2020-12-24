import 'package:elevated_seo/src/screens/components/image_chooser.dart';
import 'package:elevated_seo/src/screens/request_review.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    Provider.of<ApplicationState>(context, listen: false).getPosts();
    Provider.of<ApplicationState>(context, listen: false).getMedia();
    Provider.of<ApplicationState>(context, listen: false).getReviews();
    Provider.of<ApplicationState>(context, listen: false).getLocationInsights();
    Provider.of<ApplicationState>(context, listen: false).getServiceArea();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(primaryColor);
    double width = MediaQuery.of(context).size.width;
    width = width - 50;

    return Consumer<ApplicationState>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: primaryColor,
        key: _scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 11,
                margin: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 25,
                      backgroundImage: Image.network(
                        "https:${value.gmbUser.profilePhotoUrl}",
                      ).image,
                      onBackgroundImageError: (c, t) {
                        return Icon(Icons.error);
                      },
                    ),
                    SizedBox(width: 16),
                    Text(
                      value.gmbUser.accountName +
                          "\n(${value.locationList[value.locationIndex].locationName})",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textSizeMedium.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(top: value.scrollTop),
                child: Container(
                  padding: EdgeInsets.only(top: 28),
                  alignment: Alignment.topLeft,
                  height: MediaQuery.of(context).size.height - 100,
                  decoration: BoxDecoration(
                    color: layoutBackgroundWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: value.widgets[value.index],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: value.index == 1
            ? FloatingActionButton.extended(
                onPressed: () => Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => RequestReview()),
                ),
                label: Text("Request Review"),
              )
            : null,
        bottomNavigationBar: Material(
          color: layoutBackgroundWhite,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
                height: MediaQuery.of(context).size.height / 11,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: tabItem(0, FontAwesomeIcons.slack),
                      flex: 1,
                    ),
                    Flexible(
                      child: tabItem(1, FontAwesomeIcons.comments),
                      flex: 1,
                    ),
                    Flexible(
                      child: FloatingActionButton(
                        heroTag: "camera",
                        onPressed: () => chooseImage(context),
                        child: Icon(Icons.add_a_photo_rounded),
                        backgroundColor: primaryColor,
                      ),
                      flex: 1,
                    ),
                    Flexible(
                      child: tabItem(2, FontAwesomeIcons.chartArea),
                      flex: 1,
                    ),
                    Flexible(
                      child: tabItem(3, FontAwesomeIcons.user),
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tabItem(int pos, IconData icon) {
    ApplicationState state = Provider.of<ApplicationState>(context);
    return GestureDetector(
      onTap: () => state.changeIndex(pos),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          decoration: state.index == pos
              ? BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                )
              : BoxDecoration(),
          child: FaIcon(
            icon,
            size: 20.0.w,
            color: state.index == pos ? Colors.white : textColorSecondary,
          ),
        ),
      ),
    );
  }
}
