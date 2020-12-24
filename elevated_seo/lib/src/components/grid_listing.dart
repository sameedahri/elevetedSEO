import 'package:elevated_seo/src/model/home_page_grid_model.dart';
import 'package:elevated_seo/src/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GridListing extends StatelessWidget {
  final bool isScrollable;
  final List<HomePageGridModel> homePageGridModelList;

  GridListing(
      {this.isScrollable = false, @required this.homePageGridModelList});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: isScrollable ? ScrollPhysics() : NeverScrollableScrollPhysics(),
      itemCount: homePageGridModelList.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: homePageGridModelList[index].onTap,
          child: Container(
            alignment: Alignment.center,
            decoration: boxDecoration(
              radius: 10,
              showShadow: true,
              bgColor: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: width / 6.5,
                  width: width / 6.5,
                  margin: EdgeInsets.only(bottom: 4, top: 8),
                  padding: EdgeInsets.all(width / 30),
                  decoration: boxDecoration(
                    bgColor: homePageGridModelList[index].backgroundColor,
                    radius: 10,
                  ),
                  child: Center(
                    child: FaIcon(
                      homePageGridModelList[index].iconData,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    homePageGridModelList[index].text,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
