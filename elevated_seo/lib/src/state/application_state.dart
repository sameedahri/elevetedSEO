import 'package:elevated_seo/src/model/location_insigts_model.dart';
import 'package:elevated_seo/src/model/location_model.dart';
import 'package:elevated_seo/src/model/media_model.dart';
import 'package:elevated_seo/src/model/posts_model.dart';
import 'package:elevated_seo/src/model/review_model.dart';
import 'package:elevated_seo/src/model/service_area_model.dart';
import 'package:elevated_seo/src/model/users_model.dart';
import 'package:elevated_seo/src/screens/insights_screen.dart';
import 'package:elevated_seo/src/screens/latest_posts.dart';
import 'package:elevated_seo/src/screens/review_screen.dart';
import 'package:elevated_seo/src/screens/user_profile.dart';
import 'package:elevated_seo/src/services/api_services.dart';
import 'package:elevated_seo/src/services/local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ApplicationState extends ChangeNotifier {
  int index = 0, locationIndex = 0;
  double scrollTop = 100.0;
  Map<String, String> authHeaders = {};
  GMBUser gmbUser = GMBUser();
  List<GMBReview> reviewsList = [];
  List<GMBMedia> mediasList = [];
  List<GMBPosts> postsList = [];
  List<GMBLocation> locationList = [];
  List<GMBLocationInsights> insigtsLocation = [];
  GMBServiceArea serviceArea = GMBServiceArea();
  String mediaUrl;
  bool isVerified = false;
  bool haveReviews = false;
  bool haveInsights = false;

  List<Widget> widgets = [
    LatestPosts(),
    ReviewScreen(),
    InsightsScreen(),
    UserProfile(),
  ];

  changeIndex(int val) {
    if (val != 0) {
      scrollTop = 0;
    } else {
      scrollTop = 100.0;
    }
    this.index = val;
    notifyListeners();
  }

  setAuthHeaders(Map<String, dynamic> data) {
    this.authHeaders = data;
    notifyListeners();
  }

  setUser(GMBUser user) {
    this.gmbUser = user;
    setLocation(user);
    notifyListeners();
  }

  setReviewsList(List<GMBReview> data) {
    this.reviewsList = data;
    this.haveReviews = true;
    notifyListeners();
  }

  setMediaItems(List<GMBMedia> data) {
    this.mediasList = data;
    notifyListeners();
  }

  setInsightsList(List<GMBLocationInsights> val) {
    this.insigtsLocation = val;
    this.haveInsights = true;
    notifyListeners();
  }

  setLocationIndex(int inr) async {
    EasyLoading.show(status: "Please Wait...");
    this.locationIndex = inr;
    await LocalStorage().setIndex(inr);

    reviewsList.clear();
    mediasList.clear();
    postsList.clear();
    insigtsLocation.clear();
    haveReviews = false;
    haveInsights = false;

    getPosts(force: true);
    getMedia(force: true);
    getReviews(force: true);
    getLocationInsights(force: true);

    EasyLoading.dismiss();

    notifyListeners();
  }

  setPostsLists(List<GMBPosts> val) {
    this.postsList = val;
    notifyListeners();
  }

  setMediaUrl(String url) {
    this.mediaUrl = url;
    notifyListeners();
  }

  setServiceArea(GMBServiceArea data) {
    this.serviceArea = data;
    notifyListeners();
  }

  setLocation(GMBUser user) {
    List<GMBLocation> localist = [];

    user.locations['locations'].forEach((l) {
      localist.add(GMBLocation.fromMap(l));
    });

    locationList.addAll(localist);
  }

  getReviews({bool force = false}) async {
    if (reviewsList.isNotEmpty && !force) {
      return;
    }

    List<GMBReview> reviewList = [];
    try {
      final reviews = await ApiService(authHeaders: authHeaders).getReviews(
        gmbUser.accountNumber,
        locationList[locationIndex].name.split("/").last,
      );

      if (reviews.containsKey("reviews")) {
        reviews['reviews'].forEach((r) {
          reviewList.add(GMBReview.fromMap(r));
        });

        setReviewsList(reviewList);
      }
    } catch (e, t) {
      EasyLoading.showError("Error: $e");
      print(t);
    }
  }

  getServiceArea({bool force = false}) async {
    try {
      final servicesList = await ApiService(authHeaders: authHeaders)
          .getServiceList(gmbUser.accountNumber,
              locationList[locationIndex].name.split("/").last);

      if (servicesList.isNotEmpty) {
        setServiceArea(GMBServiceArea.fromMap(servicesList));
      }
    } catch (e, t) {
      EasyLoading.showError("Error: $e");
      print(t);
    }
  }

  getMedia({bool force = false}) async {
    if (mediasList.isNotEmpty && !force) {
      return;
    }

    List<GMBMedia> mediaList = [];
    try {
      final media = await ApiService(authHeaders: authHeaders).getMedia(
          gmbUser.accountNumber,
          locationList[locationIndex].name.split("/").last);

      if (media.containsKey("mediaItems")) {
        media['mediaItems'].forEach((m) {
          mediaList.add(GMBMedia.fromMap(m));
        });

        setMediaItems(mediaList);
      }
    } catch (e, t) {
      EasyLoading.showError("Error: $e");
      print(t);
    }
  }

  getPosts({bool force = false}) async {
    if (postsList.isNotEmpty && !force) {
      return;
    }

    List<GMBPosts> postList = [];
    try {
      final posts = await ApiService(authHeaders: authHeaders).getPosts(
          gmbUser.accountNumber,
          locationList[locationIndex].name.split("/").last);

      if (posts.containsKey("localPosts")) {
        posts['localPosts'].forEach((p) {
          postList.add(GMBPosts.fromMap(p));
        });

        setPostsLists(postList);
      }
    } catch (e, t) {
      EasyLoading.showError("Error: $e");
      print(t);
    }
  }

  getLocationInsights({bool force = false}) async {
    if (insigtsLocation.isNotEmpty && !force) {
      return;
    }

    List<GMBLocationInsights> insights = [];
    try {
      final insight =
          await ApiService(authHeaders: authHeaders).getLocationInsigts(
        gmbUser.accountNumber,
        [locationList[locationIndex].name],
        DateTime.now().subtract(Duration(days: 7)).toIso8601String() + "Z",
        DateTime.now().toIso8601String() + "Z",
      );

      if (insight.containsKey("locationMetrics")) {
        insight['locationMetrics'].forEach((i) {
          insights.add(GMBLocationInsights.fromMap(i));
        });

        setInsightsList(insights);
      }
    } catch (e, t) {
      EasyLoading.showError("Error: $e");
      print(t);
    }
  }
}
