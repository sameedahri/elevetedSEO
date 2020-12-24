import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/strings.dart';
import 'package:elevated_seo/src/utils/utils.dart';
import 'package:flutter/material.dart';

Widget logo(BuildContext context, bool isBlack) {
  return Image.asset(
    "assets/images/logo${isBlack ? "_black" : ""}.png",
    width: width(context) / 2.5,
    height: width(context) / 2.5,
  );
}

Widget text(String text,
    {var fontSize = textSizeMedium,
    textColor = textColorPrimary,
    var fontFamily = "Regular",
    var isCentered = false,
    var maxLine = 1,
    var lineThrough = false,
    var latterSpacing = 0.25,
    var textAllCaps = false,
    var isLongText = false}) {
  return Text(
    textAllCaps ? text.toUpperCase() : text,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    style: TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      color: textColor,
      height: 1.5,
      letterSpacing: latterSpacing,
    ),
  );
}

Widget titleText() {
  return Text(
    appName,
    style: TextStyle(
      color: textColorPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 22.0,
    ),
  );
}

class BackgroundContainer extends StatelessWidget {
  final List<Widget> widgets;
  final bool magringAllowed;

  const BackgroundContainer({Key key, this.widgets, this.magringAllowed = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Material(
        color: Colors.white,
        elevation: 2.0,
        borderRadius: BorderRadius.circular(4.0),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: widgets,
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const CustomButton({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: width(context),
      child: MaterialButton(
        elevation: 5.0,
        onPressed: onTap,
        color: primaryColor,
        animationDuration: Duration(milliseconds: 300),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

Widget headingText(String heading) {
  return Text(
    heading,
    style: TextStyle(
      color: textColorPrimary,
      fontWeight: FontWeight.w800,
      fontSize: 22.0,
    ),
    textAlign: TextAlign.center,
  );
}

Widget subHeadingText(String subheading) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 10,
      bottom: 16,
    ),
    child: Text(
      subheading,
      style: TextStyle(
        color: textColorSecondary,
        fontWeight: FontWeight.w400,
        fontSize: textSizeSMedium,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget addVerticalLine(double height) {
  return SizedBox(height: height);
}

class AppButton extends StatefulWidget {
  final String textContent;
  final VoidCallback onPressed;

  AppButton({@required this.textContent, @required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return AppButtonState();
  }
}

class AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: widget.onPressed,
      textColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlue],
          ),
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Text(
              widget.textContent,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
