import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ui/Home.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email,_password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print("Form is valid");
      return true;
    }
    return false;
  }

  Future validateAndSubmit () async {
    if (validateAndSave()){
      try{
        await auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        print("User signed in");
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: new Text('User signed in'),
              duration: new Duration(seconds: 10),
            ));
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
//        widget.onSignedIn();

      }
      catch (e){
        print("User not signed in" + e.toString());
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: new Text(e.toString()),
              duration: new Duration(seconds: 10),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[

          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Form(
                key: _formKey,
                child: new Theme(
                  data: new ThemeData(
                      brightness: Brightness.dark,
                      primarySwatch: Colors.teal,
                      inputDecorationTheme: new InputDecorationTheme(
                          labelStyle: new TextStyle(
                              color: Colors.teal,
                              fontSize: 20.0
                          )
                      )
                  ) ,
                  child: new Container(
                    padding: const EdgeInsets.all(40.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new TextFormField(
                          validator: (input){
                            if(input.isEmpty){
                              return 'Please Type an Email';
                            }
                          },
                          onSaved: (input) => _email = input,
                          decoration: new InputDecoration(
                            labelText: "Email",

                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        new TextFormField(
                          validator: (input){
                            if (input.length < 6) {
                              return 'Your Password is short';
                            }
                          },
                          onSaved: (input) => _password    = input,
                          decoration: new InputDecoration(
                            labelText: "Password",

                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),

                        new Padding(padding: const EdgeInsets.only(top: 20.0)

                        ),

                        new RaisedButton(
                            child: new Text("Log In"),
                            onPressed: validateAndSubmit),
                        new FlatButton(
                          child: new Text("Dont have an account? Sign up"),
                          onPressed : moveToSignUp,
                        )
                      ],

                    ),
                  ),
                ),
              )


            ],
          )
        ],
      ),
    );
  }

  Future moveToSignUp() {
//    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage(auth: new Auth ())));

  }
}