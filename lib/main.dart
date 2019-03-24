import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'rootpage.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
//  home: Home(),
      home: RootPage(auth: new Auth()),
    );
  }
}
//class Home extends StatefulWidget{
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return homeState();
//  }
//}
//
//class homeState extends State<Home>{
//  @override
//  void setState(fn) {
//    // TODO: implement setState
//    super.setState(fn);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new Scaffold(
//      appBar: new AppBar(title: new Text("Checking Firebase")
//      ,centerTitle: true,),
//      body: new Center(
//        child: new RaisedButton(onPressed: (){
//          print("Button Presse")
//        })
//      ),
//    );
//  }
//}


