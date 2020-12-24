import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevated_seo/src/components/grid_listing.dart';
import 'package:elevated_seo/src/model/home_page_grid_model.dart';
import 'package:elevated_seo/src/screens/edit_profile.dart';
import 'package:elevated_seo/src/screens/location_info.dart';
import 'package:elevated_seo/src/screens/manage_services.dart';
import 'package:elevated_seo/src/services/auth_service.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, value, child) => Container(
        padding: EdgeInsets.all(24.0),
        width: width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  "https:" + value.gmbUser.profilePhotoUrl,
                ),
                radius: MediaQuery.of(context).size.height * 0.07,
              ),
            ),
            Text(
              greetings(value.gmbUser.accountName),
              style: TextStyle(
                color: textColorPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 18.0.sp,
              ),
            ),
            SizedBox(
              height: height(context) * 0.40,
              child: GridListing(homePageGridModelList: [
                HomePageGridModel(
                  backgroundColor: colors[0][0],
                  iconData: FontAwesomeIcons.userEdit,
                  onTap: () => MyRoute.push(context, EditProfile()),
                  text: "Update Profile Details",
                ),
                HomePageGridModel(
                  backgroundColor: colors[1][0],
                  iconData: FontAwesomeIcons.businessTime,
                  onTap: () => MyRoute.push(context, ManageServices()),
                  text: "Manage Service Area & Buisness",
                ),
                HomePageGridModel(
                  backgroundColor: colors[2][0],
                  iconData: FontAwesomeIcons.locationArrow,
                  onTap: () => MyRoute.push(context, LocationInfo()),
                  text: "Location Information",
                ),
                HomePageGridModel(
                  backgroundColor: colors[3][0],
                  iconData: FontAwesomeIcons.star,
                  onTap: () => launch(
                      "https://play.google.com/store/apps/details?id=com.elevated.seo"),
                  text: "Rate us",
                )
              ]),
            ),
            Column(
              children: [
                AppButton(
                  textContent: "Logout",
                  onPressed: () async {
                    OkCancelResult result = await showOkCancelAlertDialog(
                      context: context,
                      okLabel: "Yes",
                      barrierDismissible: false,
                      title: "Logout",
                      message: "Do you really want to log out?",
                    );

                    if (result == OkCancelResult.ok) signOut(context);
                  },
                ),
                TextButton(
                  child: Text("Unlink"),
                  onPressed: () async {
                    OkCancelResult result = await showOkCancelAlertDialog(
                      context: context,
                      okLabel: "Unlink",
                      barrierDismissible: false,
                      title: "Unlink your account",
                      message: "Are you sure to unlink you GMB account?",
                    );

                    if (result == OkCancelResult.ok)
                      signOut(context, unlink: true);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
