import 'package:bloodbank/auth.dart';
import 'package:flutter/material.dart';

import './Bank.dart';
import './Donor.dart';
import './RequestBlood.dart';
import './Settings.dart';



class HomePage extends StatefulWidget {

  final BaseAuth auth;
  HomePage({this.auth});

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
          title: new Text("Blood Donation App", style: TextStyle(color: Colors.teal)),
          centerTitle: true,
          backgroundColor: Colors.black,
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
