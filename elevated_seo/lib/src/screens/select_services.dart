import 'package:elevated_seo/src/screens/home_page.dart';
import 'package:elevated_seo/src/services/api_services.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/functions.dart';
import 'package:elevated_seo/src/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SelectServiceAreas extends StatefulWidget {
  final List<String> jobIds;

  const SelectServiceAreas({Key key, this.jobIds}) : super(key: key);

  @override
  _SelectServiceAreasState createState() => _SelectServiceAreasState();
}

class _SelectServiceAreasState extends State<SelectServiceAreas> {
  List<String> addedServiceIds = [];

  _add(ApplicationState state) {
    final data = state.serviceArea.serviceItems;

    addedServiceIds.forEach((s) {
      data.add({
        "isOffered": true,
        "structuredServiceItem": {"serviceTypeId": s.split("##").last}
      });
    });
    ApiService(authHeaders: state.authHeaders).setServiceList(
      state.gmbUser.accountNumber,
      state.locationList[state.locationIndex].locationName.split("/").last,
      {"serviceItems": data},
    ).then((value) {
      state.getServiceArea(force: true);
      MyRoute.push(context, HomePage(), replaced: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(primaryColor);
    return Consumer<ApplicationState>(
      builder: (context, value, child) {
        List<String> serviceIds = [];

        value.gmbUser
            .locations['locations'][0]['primaryCategory']['serviceTypes']
            .forEach((e) {
          if (!widget.jobIds.contains(e['serviceTypeId'])) {
            serviceIds.add("${e['displayName']}##${e['serviceTypeId']}");
          }
        });

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left_rounded),
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              "Add Services",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          bottomSheet: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => this.setState(() {
                    addedServiceIds.clear();
                  }),
                  child: Text(
                    "Clear",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
                MaterialButton(
                  onPressed:
                      addedServiceIds.isNotEmpty ? () => _add(value) : null,
                  child: Text("Add New Services"),
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: serviceIds.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  if (!addedServiceIds.contains(serviceIds[index])) {
                    addedServiceIds.add(serviceIds[index]);
                  } else
                    addedServiceIds.remove(serviceIds[index]);

                  setState(() {});
                },
                tileColor: Colors.white,
                title: Text(serviceIds[index].split("##").first),
                trailing: FaIcon(
                  !addedServiceIds.contains(serviceIds[index])
                      ? FontAwesomeIcons.plus
                      : FontAwesomeIcons.minus,
                  size: 15.0,
                  color: !addedServiceIds.contains(serviceIds[index])
                      ? primaryColor
                      : Colors.red,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
