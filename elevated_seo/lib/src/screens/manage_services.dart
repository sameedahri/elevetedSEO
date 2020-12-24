import 'dart:ui';

import 'package:elevated_seo/src/screens/select_services.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ManageServices extends StatefulWidget {
  @override
  _ManageServicesState createState() => _ManageServicesState();
}

class _ManageServicesState extends State<ManageServices> {
  @override
  Widget build(BuildContext context) {
    changeStatusColor(layoutBackgroundWhite);
    return Consumer<ApplicationState>(
      builder: (context, value, child) {
        List<String> jobIds = [];

        if (value.serviceArea.serviceItems != null)
          value.serviceArea.serviceItems.forEach((element) {
            jobIds.add(element['structuredServiceItem']['serviceTypeId']);
          });

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
              "Manage Service Area",
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      value.gmbUser.locations['locations'][value.locationIndex]
                          ['primaryCategory']['displayName'],
                      style: TextStyle(
                          color: textColorPrimary, fontWeight: FontWeight.bold),
                    ),
                    tileColor: layoutBackgroundWhite,
                    subtitle: Text("Primary category"),
                  ),
                  ...jobIds.map(
                    (e) {
                      final title = value
                          .gmbUser
                          .locations['locations'][value.locationIndex]
                              ['primaryCategory']['serviceTypes']
                          .firstWhere((t) => t['serviceTypeId'] == e);

                      return ListTile(
                        title: Text(title['displayName']),
                      );
                    },
                  ),
                  if (value.gmbUser.locations['locations'][value.locationIndex]
                          ['locationState']['canModifyServiceList'] ==
                      true) ...{
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        child: Text("Add another service"),
                        onPressed: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                SelectServiceAreas(jobIds: jobIds),
                          ),
                        ),
                        color: primaryColor,
                        textColor: Colors.white,
                      ),
                    )
                  } else
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "You don't have permission to add services. (Verification Pending)",
                        style: TextStyle(
                          color: textColorPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
