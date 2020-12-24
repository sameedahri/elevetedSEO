import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showMessage(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    webBgColor: "#000",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
  );
}

Widget loadingBtn() {
  return Material(
    color: Colors.blue,
    animationDuration: Duration(milliseconds: 400),
    elevation: 8.0,
    shape: StadiumBorder(),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Loading, Please wait...',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 15),
        ],
      ),
    ),
  );
}
