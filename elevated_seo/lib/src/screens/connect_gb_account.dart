import 'package:elevated_seo/src/components/custom_dialog.dart';
import 'package:elevated_seo/src/model/users_model.dart';
import 'package:elevated_seo/src/services/api_services.dart';
import 'package:elevated_seo/src/services/local_storage.dart';
import 'package:elevated_seo/src/services/secrets.dart';
import 'package:elevated_seo/src/state/application_state.dart';
import 'package:elevated_seo/src/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class ConnectGBAccount extends StatefulWidget {
  @override
  _ConnectGBAccountState createState() => _ConnectGBAccountState();
}

class _ConnectGBAccountState extends State<ConnectGBAccount> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount signInAccount = await GoogleSignIn(
        clientId: clientId,
        scopes: scopes,
      ).signIn();

      EasyLoading.show(status: "Please Wait..");

      final GoogleSignInAuthentication authentication =
          await signInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      final User user = _auth.currentUser;
      await user.linkWithCredential(credential);

      Map<String, String> authHeaders = await signInAccount.authHeaders;
      Provider.of<ApplicationState>(context, listen: false)
          .setAuthHeaders(authHeaders);

      final data = await ApiService(authHeaders: authHeaders).connectAccount();
      print(data);

      final locations = await ApiService(authHeaders: authHeaders)
          .getLocations(data['accounts'][0]['name'].split("/").last);

      GMBUser gmbUser = GMBUser(
        accountName: data['accounts'][0]['accountName'],
        accountNumber: data['accounts'][0]['name'].split("/").last,
        email: user.email,
        profilePhotoUrl: data['accounts'][0]['profilePhotoUrl'],
        state: data['accounts'][0]['state'],
        type: data['accounts'][0]['type'],
        uid: user.uid,
        locations: locations,
      );

      if (data.isNotEmpty) {
        await userRef.doc(user.uid).update(gmbUser.toMap());
        await LocalStorage().setAuthStatus("SIGNED_IN");
        Provider.of<ApplicationState>(context, listen: false).setUser(gmbUser);

        LocalStorage().setToken([
          await signInAccount.authentication.then((value) => value.accessToken),
          DateTime.now().toString()
        ]);

        EasyLoading.dismiss();
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(),
        );
      } else {
        showMessage("Error");
        EasyLoading.dismiss();
      }
    } catch (e, track) {
      showMessage("Error: $e");
      print(track);
    }
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.white);
    return Scaffold(
      body: Container(
        width: width(context),
        padding: EdgeInsets.all(24),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/1.png",
              width: width(context) * 0.70,
            ),
            addVerticalLine(20.0),
            Text(
              "Connect your Google My Buisness Account",
              style: TextStyle(
                color: textColorPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 22.0,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 16,
              ),
              child: Text(
                "Grow your buisness with elevated seo",
                style: TextStyle(
                  color: textColorSecondary,
                  fontWeight: FontWeight.w400,
                  fontSize: textSizeSMedium,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            addVerticalLine(10.0),
            AppButton(
              textContent: "Connect Now",
              onPressed: signInWithGoogle,
            ),
          ],
        ),
      ),
    );
  }
}
