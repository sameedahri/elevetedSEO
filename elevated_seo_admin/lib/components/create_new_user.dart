import 'package:elevated_seo_admin/models/users_model.dart';
import 'package:elevated_seo_admin/services/auth_service.dart';
import 'package:elevated_seo_admin/utils/utils.dart';
import 'package:flutter/material.dart';

class CreateNewUser extends StatefulWidget {
  @override
  _CreateNewUserState createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  String firstName, lastName, emailAddress, password;

  submit() {
    if (_formState.currentState.validate()) {
      _formState.currentState.save();

      AuthService()
          .addNewUser(emailAddress, password, [firstName, lastName].join(" "))
          .then((value) {
        showMessage("Added!");
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create a New User'),
      scrollable: true,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.50,
        child: Form(
          key: _formState,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      validator: (value) =>
                          value.isEmpty ? 'This field can\'t be empty.' : null,
                      onSaved: (newValue) => firstName = newValue.trim(),
                      decoration: InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      validator: (value) =>
                          value.isEmpty ? 'This field can\'t be empty.' : null,
                      onSaved: (newValue) => lastName = newValue.trim(),
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value.isEmpty || !value.contains('.com')
                    ? 'Please enter a valid email address.'
                    : null,
                onSaved: (newValue) => emailAddress = newValue.trim(),
                decoration: InputDecoration(
                  labelText: 'Email Address',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) =>
                    value.isEmpty ? 'This field can\'t be empty.' : null,
                onSaved: (newValue) => password = newValue.trim(),
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
          textColor: Colors.blue,
        ),
        MaterialButton(
          onPressed: submit,
          child: Text('Proceed'),
          textColor: Colors.blue,
        ),
      ],
    );
  }
}
