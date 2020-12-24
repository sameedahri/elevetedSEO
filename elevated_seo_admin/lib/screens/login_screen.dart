import 'package:elevated_seo_admin/services/auth_service.dart';
import 'package:elevated_seo_admin/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _pass;
  bool loading = false;

  submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        loading = true;
      });

      AuthService().login(_email, _pass, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.blue,
        padding: const EdgeInsets.all(50),
        child: Material(
          elevation: 10.0,
          color: Colors.white,
          animationDuration: Duration(milliseconds: 300),
          borderRadius: BorderRadius.circular(15),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/logo_black.png",
                    fit: BoxFit.cover,
                  ),
                ),
                flex: 2,
              ),
              loginArea(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded loginArea() {
    return Expanded(
      child: Material(
        elevation: 10,
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
        animationDuration: Duration(milliseconds: 300),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to ElevatedSEO Admin",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Login in, to see it in action.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 25),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    isDense: true,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) => !value.contains('.com')
                      ? 'Please enter a valid email address.'
                      : null,
                  onSaved: (newValue) => _email = newValue.trim(),
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    isDense: true,
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validator: (value) =>
                      value.isEmpty ? 'Please enter a valid password.' : null,
                  onSaved: (newValue) => _pass = newValue.trim(),
                ),
                SizedBox(height: 20),
                !loading
                    ? Container(
                        width: double.infinity,
                        height: 45,
                        child: RaisedButton(
                          onPressed: submit,
                          child: Text("Login"),
                          textColor: Colors.white,
                          elevation: 2.0,
                          hoverElevation: 10.0,
                          hoverColor: Colors.teal,
                          color: Colors.blue,
                          animationDuration: Duration(milliseconds: 400),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      )
                    : loadingBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
