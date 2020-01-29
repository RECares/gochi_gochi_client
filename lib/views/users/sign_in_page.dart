import 'package:flutter/material.dart';

import 'package:gochi_gochi_client/models/user.dart';
import 'package:gochi_gochi_client/views/maps/map_page.dart';
import 'package:gochi_gochi_client/views/users/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var _emailTextController = TextEditingController();

  var _passwordTextController = TextEditingController();

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
                    child: Text('Sign in', style: TextStyle(fontSize: 60))),
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
                      obscureText: true,
                      controller: this._passwordTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      )),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        child: Text('Sign up'),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(_createRoute(SignUpPage()));
                        }),
                    RaisedButton(child: Text('Submit'), onPressed: _signIn),
                  ],
                ),
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
    super.dispose();
  }

  void _signIn() async {
    // TODO: Disable user interaction here.
    var user = User(
        email: _emailTextController.text,
        password: _passwordTextController.text);
    var response = await user.signIn();
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
      },
    );
  }
}
