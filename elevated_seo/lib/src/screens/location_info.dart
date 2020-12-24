import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LocationInfo extends StatefulWidget {
  @override
  _LocationInfoState createState() => _LocationInfoState();
}

class _LocationInfoState extends State<LocationInfo> {
  double height = 0;

  @override
  Widget build(BuildContext context) {
    changeStatusColor(layoutBackgroundWhite);

    return Consumer<ApplicationState>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: layoutBackgroundWhite,
            elevation: 0.0,
            leading: IconButton(
              icon: FaIcon(FontAwesomeIcons.arrowLeft),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(
              "Location Info",
            ),
            // actions: [
            //   IconButton(
            //     icon: FaIcon(FontAwesomeIcons.locationArrow),
            //     onPressed: () => this.setState(() {
            //       if (height == 0.0)
            //         height = MediaQuery.of(context).size.height * 0.75;
            //       else
            //         height = 0.0;
            //     }),
            //   )
            // ],
          ),
          // bottomSheet: Card(
          //   shadowColor: primaryColor,
          //   elevation: 4.0,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(8.0),
          //   ),
          //   child: Container(
          //     height: height,
          //     padding: EdgeInsets.all(5.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         _getData(
          //           value.locationList[value.locationIndex]
          //                   .address['addressLines'][0] +
          //               ", " +
          //               value.locationList[value.locationIndex]
          //                   .address['locality'] +
          //               ", " +
          //               value.locationList[value.locationIndex]
          //                   .address['administrativeArea'],
          //           "Address",
          //         ),
          //         _getData(
          //             value.locationList[value.locationIndex]
          //                 .primaryCategory['displayName'],
          //             "Category"),
          //         ...value.locationList[value.locationIndex]
          //             .serviceArea['places']['placeInfos']
          //             .map<Widget>((e) => _getData(e['name'], "Service Area"))
          //             .toList()
          //       ],
          //     ),
          //   ),
          // ),
          body: value.locationList.isNotEmpty
              ? ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  shrinkWrap: true,
                  itemCount: value.locationList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: value.locationIndex == index ? 5.0 : 0.0,
                      color: Colors.white,
                      shadowColor: primaryColor,
                      child: ListTile(
                        onTap: () {
                          Provider.of<ApplicationState>(context, listen: false)
                              .setLocationIndex(index);
                        },
                        title: Text(
                          value.locationList[index].locationName ?? '',
                          style: TextStyle(
                            color: textColorPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          value.locationList[index]
                                  .primaryCategory['displayName'] ??
                              '',
                        ),
                        trailing: value.locationIndex == index
                            ? FaIcon(
                                FontAwesomeIcons.checkCircle,
                                color: Colors.green,
                              )
                            : null,
                      ),
                    );
                  },
                )
              : SizedBox(),
        );
      },
    );
  }
}

Widget _getData(String title, String sub) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(color: textColorPrimary, fontWeight: FontWeight.bold),
    ),
    tileColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    subtitle: Text(sub),
  );
}
