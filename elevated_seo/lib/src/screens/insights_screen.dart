import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InsightsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, value, child) {
        if (!value.haveInsights)
          return Center(
            child: Text(
              "You don't have any insights",
              style: TextStyle(
                  color: textColorPrimary, fontWeight: FontWeight.w600),
            ),
          );

        return GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: value.insigtsLocation[0].metricValues.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int i) {
            return value.insigtsLocation[0].metricValues[i]['metric'] != null
                ? GestureDetector(
                    onTap: () {
                      showOkCancelAlertDialog(
                        context: context,
                        cancelLabel: "",
                        okLabel: "Dismiss",
                        title: convertInsigtsDataToSimple(value
                            .insigtsLocation[0].metricValues[i]['metric'])[0],
                        message: convertInsigtsDataToSimple(value
                            .insigtsLocation[0].metricValues[i]['metric'])[1],
                      );
                    },
                    child: Material(
                      color: Color(0xff073d97),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            value.insigtsLocation[0].metricValues[i]
                                ['totalValue']['value'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                          Text(
                            convertInsigtsDataToSimple(value.insigtsLocation[0]
                                .metricValues[i]['metric'])[0],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox();
          },
        );
      },
    );
  }
}
