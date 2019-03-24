import 'package:bloodbank/LoginPage.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'ui/Home.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage> {

  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId){
      setState(() {
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn(){
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (authStatus == AuthStatus.notSignedIn)
      return new LoginPage(
        auth: widget.auth,
        onSignedIn: _signedIn
      );
    else
      return new HomePage();


  }
}
