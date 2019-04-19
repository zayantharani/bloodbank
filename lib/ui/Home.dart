import 'package:bloodbank/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import './Bank.dart';
import './Donor.dart';
import './RequestBlood.dart';
import './Settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut; // To go back
  final FirebaseDatabase database = FirebaseDatabase.instance;
//  var name,phone,
//  HomePage();
  HomePage({this.auth,this.onSignedOut});
  void _signOut() async {
    try{
      await auth.signOut();
      onSignedOut();
    } catch (e){
      print("hhhelloooo"+e);
    }
  }
//  {
//    user = await auth.currentUser();
//    print("This user "+ auth.currentUser().toString());
//    database.reference().child("Users").once().then((DataSnapshot snapshot){
//      Map<dynamic,dynamic> data = snapshot.value;
//      data.forEach((K,V){
//        print("key"+K);
//        print("Valuees"+V);
//      });
//    print(data.values);
//    });
//    user = auth.currentUser();
//    initializeUser();


  @override
  State<StatefulWidget> createState() {
    return new homeState();
  }
}


class homeState extends State<HomePage> {

//  userInfo info;
  String fullName;
  String phone;
  String email;
  String bloodGroup;

  FirebaseAuth fireAuth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeUser();
  }

  Future<String> initializeUser() async{
    print("!!!!! initUser Called!!!!!!");
    final FirebaseUser user = await fireAuth.currentUser();
    print("Child ID"+user.uid);
    var nameRef = await FirebaseDatabase.instance.reference().child("Users").child(user.uid).child('Full Name').once();
    var bloodGroupRef = await FirebaseDatabase.instance.reference().child("Users").child(user.uid).child('BloodGroup').once();
    var emailRef = await FirebaseDatabase.instance.reference().child("Users").child(user.uid).child('Email').once();
    var phoneRef = await FirebaseDatabase.instance.reference().child("Users").child(user.uid).child('Phone').once();
    print("This is it!!!!!!!!"+nameRef.toString());
//    fullName = await FirebaseDatabase.instance.reference().child("Users").child(user.uid).once().toString();
    setState(() {
      fullName = nameRef.value.toString();
//    print(fullName);
      email = emailRef.value.toString();
      bloodGroup = bloodGroupRef.value.toString();
      phone = phoneRef.value.toString();
//    info = new userInfo(Name, email, phone, bloodGroup);
    });
    }

  @override
  Widget build(BuildContext context) {
    print("!!!!! Build Called!!!!!!");
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Blood Donation App"),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: new Container(
          child: new Column(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Container(
                child:
                new Text("Name: $fullName", style: new TextStyle(fontSize: 18.3)),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                margin: EdgeInsets.all(0.0),
              ),new Container(
                child:
                new Text("Email: $email", style: new TextStyle(fontSize: 18.3)),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                margin: EdgeInsets.all(0.0),
              ),new Container(
                child:
                new Text("Phone: $phone", style: new TextStyle(fontSize: 18.3)),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                margin: EdgeInsets.all(0.0),
              ),new Container(
                child:
                new Text("BloodGroup: $bloodGroup", style: new TextStyle(fontSize: 18.3)),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                margin: EdgeInsets.all(0.0),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 100.0,
                child: DrawerHeader(
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0, 0),
                  child: Text(
                    'Life Saviour',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: .5,
                        fontSize: 23.0,
                        color: Colors.teal,
                        fontWeight: FontWeight.w600),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: Text('View Blood Banks'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Bank(),
                      ));
                  // Update the state of the app
                  // ...
                },
              ),
              ListTile(
                title: Text('Donate'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Donor(),
                      ));
                  // Update the state of the app
                  // ...
                },
              ),
              ListTile(
                title: Text('Request Blood'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RequiredBlood(),
                      ));
                  // Update the state of the app
                  // ...
                },
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Settings(),
                      ));
                  // Update the state of the app
                  // ...
                },
              ),
              ListTile(
                title: Text('Logout'),
//                onLongPress: widget._signOut(),
                onTap: () {
                  // ignore: unnecessary_statements
                  widget._signOut;
//                  Navigator.pop(context);
//                  Navigator.pop(context);
//                  widget.auth.signOut();
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                  // Update the state of the app
                  // ...
                },
              ),
            ],
          ),
        ));
  }
}

//class userInfo{
//  String fullName;
//  String phone;
//  String email;
//  String bloodGroup;
//  userInfo(this.fullName,this.phone,this.email,this.bloodGroup);
//
//  String getfullName(){
//    return fullName;
//  }
//}


//Future<void> signOut() async {
//  return FirebaseAuth.instance.signOut();
//}
//void _signOut() async{
//  FirebaseAuth.instance.signOut();
////  FirebaseUser user = FirebaseAuth.instance.currentUser;
//  //print('$user');
//  runApp(
//      new MaterialApp(
//        home: new LoginPage(),
//      )
//
//  );
//}