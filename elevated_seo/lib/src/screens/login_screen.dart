import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elevated_seo/src/model/users_model.dart';
import 'package:elevated_seo/src/screens/connect_gb_account.dart';
import 'package:elevated_seo/src/services/auth_service.dart';
import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/constants.dart';
import 'package:elevated_seo/src/utils/functions.dart';
import 'package:elevated_seo/src/utils/route.dart';
import 'package:elevated_seo/src/utils/utils.dart';
import 'package:elevated_seo/src/utils/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/foundation.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController email;
  TextEditingController password;

  loginUsingEmail() async {
    if (_formKey.currentState.validate()) {
      EasyLoading.show(status: "Loading..");
      try {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        )
            .then((value) async {
          if (value.user != null) {
            EasyLoading.dismiss();

            DocumentSnapshot doc = await userRef.doc(value.user.uid).get();
            if (GMBUser.fromMap(doc.data()).accountNumber != null)
              authenticate(context);
            else
              MyRoute.push(context, ConnectGBAccount(), replaced: true);
          }
        }).catchError((e, track) {
          EasyLoading.dismiss();
          showMessage("Error: $e");
          print(track);
        });
      } catch (e, stack) {
        EasyLoading.showError("Error: $e");
        print(stack);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    if (!kReleaseMode) {
      email.text = "test@elevated.com";
      password.text = "123456";
    }
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.white);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          margin: EdgeInsets.only(left: 24.0, right: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image.asset(
                  "assets/images/logo_black.png",
                  width: width(context) * 0.70,
                ),
                SizedBox(height: 20.0),
                Text(
                  "Managing your GMB was never so easy",
                  style: TextStyle(
                    color: textColorPrimary,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.25,
                  ),
                ),
                SizedBox(height: 24.0),
                TextFormField(
                  controller: email,
                  validator: (value) => value.isEmpty ||
                          !value.contains("@") ||
                          !value.contains(".com")
                      ? "This field is required."
                      : null,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 4, 8),
                    labelText: "Email Address",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: viewColor, width: 0.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: viewColor, width: 0.0),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: textSizeMedium,
                    color: textColorPrimary,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: password,
                  validator: (value) => value.isEmpty || value.length < 6
                      ? "This field is required."
                      : null,
                  cursorColor: primaryColor,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 4, 8),
                    labelText: "Password",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: viewColor, width: 0.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: viewColor, width: 0.0),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: textSizeMedium,
                    color: textColorPrimary,
                  ),
                ),
                SizedBox(height: 32.0),
                AppButton(
                  onPressed: loginUsingEmail,
                  textContent: "Login",
                ),
                SizedBox(height: 24.0),
                Text(
                  "Forget Password?",
                  style: TextStyle(
                    color: textColorSecondary,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Medium",
                    letterSpacing: 0.25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
