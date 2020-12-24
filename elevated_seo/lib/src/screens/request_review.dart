import 'package:elevated_seo/src/utils/colors.dart';
import 'package:elevated_seo/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestReview extends StatefulWidget {
  @override
  _RequestReviewState createState() => _RequestReviewState();
}

class _RequestReviewState extends State<RequestReview> {
  final _formKey = GlobalKey<FormState>();
  String value = '';
  String textField1, messageField;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Request Review",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomSheet: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Material(
          elevation: 5.0,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    String urlString;
                    if (value == "Phone Number")
                      urlString = "sms:$textField1";
                    else
                      urlString =
                          "mailto:$textField1?subject=&body=$messageField";

                    if (await canLaunch(urlString)) {
                      launch(urlString);
                    }
                  }
                },
                child: Text("Request"),
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                textColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField(
                  onChanged: (val) {
                    setState(() {
                      value = val;
                    });
                  },
                  onSaved: (val) => value = val,
                  decoration: InputDecoration(
                    labelText: "Choose type",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (val) =>
                      value == null ? "This field is required." : null,
                  items: ["Email Address", "Phone Number"]
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                      .toList(),
                ),
                addVerticalLine(10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: value,
                    helperText: value == "Phone Number"
                        ? "Please add country code"
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: value == "Phone Number"
                      ? TextInputType.number
                      : TextInputType.emailAddress,
                  onSaved: (val) => textField1 = val,
                  validator: (val) => val.isEmpty
                      ? "This field is required."
                      : value == "Phone Number"
                          ? !val.startsWith("+")
                              ? "Country Code is required."
                              : null
                          : !val.contains(".com")
                              ? "Please enter a valid email address"
                              : null,
                ),
                addVerticalLine(10.0),
                value == "Email Address"
                    ? SizedBox(
                        height: 100,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Message",
                            helperText: "Your Message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          onSaved: (val) => messageField = val,
                          textCapitalization: TextCapitalization.words,
                          validator: (val) =>
                              val.isEmpty ? "This field is required." : null,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
