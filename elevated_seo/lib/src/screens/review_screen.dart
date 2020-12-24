import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevated_seo/src/model/review_model.dart';
import 'package:elevated_seo/src/services/api_services.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatefulWidget {
  final bool isHomeScreen;

  const ReviewScreen({Key key, this.isHomeScreen = false}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    changeStatusColor(primaryColor);
    return Consumer<ApplicationState>(
      builder: (context, value, child) {
        if (!value.haveReviews)
          return Center(
            child: Text(
              "You don't have any reviews",
              style: TextStyle(
                  color: textColorPrimary, fontWeight: FontWeight.w600),
            ),
          );

        return ListView.builder(
          shrinkWrap: true,
          itemCount: widget.isHomeScreen
              ? getItemCount(value.reviewsList.length)
              : value.reviewsList.length,
          physics: widget.isHomeScreen
              ? NeverScrollableScrollPhysics()
              : BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          itemBuilder: (context, index) {
            GMBReview review = value.reviewsList[index];

            return Material(
              child: Column(
                children: [
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(review.reviewer['displayName']),
                        RatingBar(
                          ratingWidget: RatingWidget(
                            full: FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.redAccent,
                            ),
                            half: FaIcon(
                              FontAwesomeIcons.solidStarHalf,
                              color: Colors.redAccent,
                            ),
                            empty: FaIcon(
                              FontAwesomeIcons.star,
                              color: Colors.redAccent,
                            ),
                          ),
                          onRatingUpdate: (e) {},
                          itemSize: 20,
                          ignoreGestures: true,
                          itemPadding: EdgeInsets.only(left: 2.0),
                          initialRating: countRatings(review.starRating),
                          glowColor: Colors.redAccent,
                        )
                      ],
                    ),
                    subtitle: Text(
                      getDateString(review.updateTime),
                      style: TextStyle(fontSize: 11.0),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: CachedNetworkImageProvider(
                        review.reviewer['profilePhotoUrl'],
                      ),
                      onBackgroundImageError: (e, t) => Container(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: viewColor),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(review.comment ?? "No Comment."),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            List<String> data = await showTextInputDialog(
                              context: context,
                              message: review.reviewReply != null
                                  ? review.reviewReply['comment']
                                  : null,
                              textFields: [
                                DialogTextField(
                                  hintText: "Enter your reply",
                                  validator: (value) => value.isEmpty
                                      ? "This field is required."
                                      : null,
                                )
                              ],
                              title: review.reviewReply != null
                                  ? "Update your reply"
                                  : "Reply to ${review.reviewer['displayName']}",
                              okLabel: "Reply",
                              barrierDismissible: false,
                            );
                            if (data != null) {
                              final result = await ApiService(
                                authHeaders: Provider.of<ApplicationState>(
                                  context,
                                  listen: false,
                                ).authHeaders,
                              ).updateReply(review.name, data[0]);
                              if (result.isNotEmpty) {
                                Provider.of<ApplicationState>(context,
                                        listen: false)
                                    .getReviews(force: true);
                                EasyLoading.showSuccess("Success!");
                              }
                            }
                          },
                          icon: Icon(Icons.reply_outlined),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  double countRatings(String starRating) {
    if (starRating == "ONE")
      return 1;
    else if (starRating == "TWO")
      return 2;
    else if (starRating == "THREE")
      return 3;
    else if (starRating == "FOUR")
      return 4;
    else if (starRating == "FIVE")
      return 5;
    else
      return 0;
  }
}
