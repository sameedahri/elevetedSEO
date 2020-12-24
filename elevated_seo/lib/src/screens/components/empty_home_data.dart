import 'package:elevated_seo/src/utils/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EmptyHomeData extends StatelessWidget {
  final String title, buttonText;
  final Function onTap;

  const EmptyHomeData(
      {Key key,
      @required this.title,
      @required this.buttonText,
      @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "You don't have any $title.",
                style: TextStyle(
                  color: textColorPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: " " + buttonText,
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    onTap();
                  },
              )
            ]),
          ),
        ),
      ),
    );
  }
}
