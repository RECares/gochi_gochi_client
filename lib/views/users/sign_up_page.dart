import 'package:flutter/material.dart';

import 'package:gochi_gochi_client/models/user.dart';
import 'package:gochi_gochi_client/views/maps/map_page.dart';
import 'package:gochi_gochi_client/views/users/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var _emailTextController = TextEditingController();

  var _passwordTextController = TextEditingController();

  var _confirmPasswordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Welcome')),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Sign up', style: TextStyle(fontSize: 60))),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                      controller: this._emailTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      )),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                      controller: this._passwordTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      obscureText: true),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                      controller: this._confirmPasswordTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm password',
                      ),
                      obscureText: true),
                ),
                ButtonBar(alignment: MainAxisAlignment.center, children: [
                  FlatButton(
                      child: Text('Sign in'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(_createRoute(SignInPage()));
                      }),
                  RaisedButton(child: Text('Submit'), onPressed: _signUp),
                ]),
                FlatButton(
                    child: Text('Continue as guest'),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacement(_createRoute(MapPage()));
                    }),
              ])),
        ));
  }

  @override
  void dispose() {
    this._emailTextController.dispose();
    this._passwordTextController.dispose();
    this._confirmPasswordTextController.dispose();
    super.dispose();
  }

  void _signUp() async {
    // TODO: Disable user interaction here.
    if (_passwordTextController.text != _confirmPasswordTextController.text) {
      // TODO: Display error message.
      return;
    }
    var user = User(
        email: _emailTextController.text,
        password: _passwordTextController.text);
    var response = await user.signUp();
    if (response.statusCode == 201) {
      Navigator.of(context).pushReplacement(_createRoute(MapPage()));
    } else {
      // TODO: Display an error message.
    }
    // TODO: Enable user interaction here.
  }

  Route _createRoute(Widget widget) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        });
  }
}
