import 'package:flutter/material.dart';

import './Donor.dart';
import './Home.dart';
import './RequestBlood.dart';
import './Settings.dart';

class Bank extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BankState();
  }
}

class BankState extends State<Bank> {
  // will be of bank datatype
  List<String> _data = new List<String>();

  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < 30; i++) {
      _data.add("i");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text("Blood Banks"),
        ),
        body: new Container(
          alignment: Alignment.topCenter,
          child: new ListView.builder(
              itemCount: _data.length,
              itemBuilder: (BuildContext context,int index){
                return new Card(
                  child: new Container(
                    padding: new EdgeInsets.all(32.0),
                    child: new Column(
                      children: <Widget>[
                        new Text("Item#$index"),
                      ],
                    ),
                  ),
                );
              }
          ),
//        child: ListView(
////          shrinkWrap: true,
//          padding: const EdgeInsets.all(20.0),
//          children: <Widget>[
//            // loop here through bank collection and display the info of each back
//            Card(
//              child: const Text('I\'m dedicating every day to you'),
//            ),
//          ],
//        )
        ));
  }
}


class homeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Blood Donation App"),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
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
                        color: Colors.brown,
                        fontWeight: FontWeight.w600),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
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
                onTap: () {
                  Navigator.pop(context);
                  // Update the state of the app
                  // ...
                },
              ),
            ],
          ),
        ));
  }
}
