import 'package:flutter/material.dart';

import './Bank.dart';
import './Donor.dart';
import './RequestBlood.dart';
import './Settings.dart';
//import 'package:firebase_database/firebase_database.dart';



class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new homeState();
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
                        builder: (context) => RequestBlood(),
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
