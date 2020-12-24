import 'dart:async';

import 'package:elevated_seo/src/screens/login_screen.dart';
import 'package:elevated_seo/src/services/auth_service.dart';
import 'package:elevated_seo/src/services/local_storage.dart';
import 'package:elevated_seo/src/utils/functions.dart';
import 'package:elevated_seo/src/utils/route.dart';
import 'package:elevated_seo/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;
  LocalStorage localStorage;

  _userSignIn() async {
    if ((await localStorage.getToken()).isNotEmpty) {
      final testCase = DateTime.now()
          .difference(DateTime.parse((await localStorage.getToken())[1]));
      if (testCase.inSeconds < 3600) {
        Map<String, String> jsonData = {
          "Authorization": "Bearer ${(await localStorage.getToken())[0]}"
        };
        redirectUser(context, jsonData);
      } else {
        authenticate(context);
      }
    } else {
      authenticate(context);
    }
  }

  initialize() async {
    localStorage = LocalStorage();
    String authStatus = await localStorage.checkAuthenticatorStatus();

    Logger().i(authStatus);

    switch (authStatus) {
      case "PENDING":
        Timer(
          Duration(seconds: 2),
          () => MyRoute.push(context, LoginScreen(), replaced: true),
        );
        break;
      case "SIGNED_IN":
        _userSignIn();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: MediaQuery.of(context).size);
    changeStatusColor(Colors.white);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/images/start.gif",
          width: width(context) * 0.85,
        ),
      ),
    );
  }
}
