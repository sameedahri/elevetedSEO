import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elevated_seo/src/model/users_model.dart';
import 'package:elevated_seo/src/screens/home_page.dart';
import 'package:elevated_seo/src/screens/login_screen.dart';
import 'package:elevated_seo/src/services/api_services.dart';
import 'package:elevated_seo/src/services/local_storage.dart';
import 'package:elevated_seo/src/services/secrets.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/constants.dart';
import 'package:elevated_seo/src/utils/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

Future<void> authenticate(BuildContext context) async {
  final GoogleSignInAccount signInAccount = await GoogleSignIn(
    clientId: clientId,
    scopes: scopes,
  ).signIn();

  Map<String, String> authHeaders = await signInAccount.authHeaders;
  String token =
      await signInAccount.authentication.then((value) => value.accessToken);

  redirectUser(context, authHeaders, token: token);
}

void signOut(BuildContext context, {bool unlink = false}) async {
  LocalStorage localStorage = LocalStorage();

  await localStorage.setToken([]);

  if (unlink) {
    User user = FirebaseAuth.instance.currentUser;

    UserInfo userInfo = user.providerData
        .firstWhere((element) => element.providerId.contains("google.com"));
    print(userInfo.providerId);

    userRef
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({'uid': FirebaseAuth.instance.currentUser.uid, 'email': ''});

    user.unlink(userInfo.providerId).then((value) async {
      GoogleSignIn().signOut();
    }).catchError((e, t) {
      EasyLoading.showError("Error: $e");
      print(t);
    });
  }

  FirebaseAuth.instance.signOut();
  MyRoute.push(context, LoginScreen(), replaced: true);
}

redirectUser(BuildContext context, Map<String, String> headers,
    {String token}) async {
  try {
    Provider.of<ApplicationState>(context, listen: false)
        .setAuthHeaders(headers);
    // final data = await ApiService(authHeaders: headers).connectAccount();

    final DocumentSnapshot value =
        await userRef.doc(FirebaseAuth.instance.currentUser.uid).get();

    GMBUser gmbUser = GMBUser.fromMap(value.data());

    if (value.exists)
      Provider.of<ApplicationState>(context, listen: false).setUser(gmbUser);

    if (gmbUser.locations == null) {
      final locations = await ApiService(authHeaders: headers)
          .getLocations(gmbUser.accountNumber);
      userRef.doc(gmbUser.uid).update({"locations": locations});
    }

    if (token != null)
      LocalStorage().setToken([token, DateTime.now().toString()]);

    MyRoute.push(context, HomePage(), replaced: true);
  } catch (e, t) {
    EasyLoading.showError(e.toString());
    Logger().e(t);
  }
}
