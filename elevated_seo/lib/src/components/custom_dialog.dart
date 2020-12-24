import 'package:elevated_seo/src/screens/home_page.dart';
import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/route.dart';
import 'package:elevated_seo/src/utils/utils.dart';
import 'package:elevated_seo/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  _goToTheHomePage(BuildContext context) {
    MyRoute.push(context, HomePage(), replaced: true);
  }

  dialogContent(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.centerRight,
              child: Icon(Icons.close, color: textColorPrimary),
            ),
          ),
          text(
            "Congratulations!",
            textColor: Colors.green,
            fontSize: textSizeLarge,
          ),
          SizedBox(height: 24),
          Image.asset(
            "assets/images/check.png",
            width: 150,
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(
              "Your account has been successfully connected.",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: textColorPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              _goToTheHomePage(context);
            },
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: new BoxDecoration(
                color: primaryColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: text(
                "Continue",
                textColor: Colors.white,
                fontFamily: "Medium",
                fontSize: textSizeNormal,
              ),
            ),
          )
        ],
      ),
    );
  }
}
