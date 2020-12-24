import 'package:elevated_seo/src/screens/latest_posts.dart';
import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderImage extends StatelessWidget {
  final String title, subtitle;
  final bool isListEmpty;

  const HeaderImage({Key key, this.title, this.isListEmpty, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColorPrimary,
              fontSize: 18.0.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextButton(
            onPressed: () {
              if (isListEmpty)
                EasyLoading.showToast(
                    "You don't have any ${subtitle.toLowerCase()}.");
              else
                MyRoute.push(context, SeeAll(title: subtitle));
            },
            child: Text("See All"),
          )
        ],
      ),
    );
  }
}
