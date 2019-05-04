import 'dart:async';

import 'package:bloodbank/LoginPage.dart';
import 'package:bloodbank/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:bloodbank/Bank.dart';
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
  List<DonorInfo> bloodRequests = new List<DonorInfo>();
  DonorInfo dInfo;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.notifications),
              onPressed: () {
//                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Notification(),
                    ));
              },
            )
          ],
          title: new Text("Blood Donation App",
              ),
          centerTitle: true,

        ),
        body: new Container(
          child: profile(),
        ),
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
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
                  _signOut();
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                })
          ]),
        ));
  }

  Future _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

class DonorInfo {
  String name, group, num;

  DonorInfo(this.name, this.group, this.num);
}

var user;
FirebaseAuth auth = FirebaseAuth.instance;

Future<DataSnapshot> getInfo() async {
  user = await auth.currentUser();
  DataSnapshot nameRef = await FirebaseDatabase.instance
      .reference()
      .child("Users")
      .child(user.uid)
      .once();
  return nameRef;
}

// Display Profile Info
Widget profile() {
  return new FutureBuilder(
      future: getInfo(),
      builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
        if (snapshot.hasData) {
          Map<dynamic, dynamic> data = snapshot.data.value;
          print(data['Full Name'].toString());
          return new Container(padding: EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new Text("Name: ${data['Full Name']}",
                      style: Theme.of(context).textTheme.title),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                  margin: EdgeInsets.all(0.0),
                ),
                new Container(
                  child: new Text("Email: ${data['Email']}",
                      style: Theme.of(context).textTheme.title),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                  margin: EdgeInsets.all(0.0),
                ),
                new Container(
                  child: new Text("Phone: ${data['Phone']}",
                      style: Theme.of(context).textTheme.title),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                  margin: EdgeInsets.all(0.0),
                ),
                new Container(
                  child: new Text("BloodGroup: ${data['BloodGroup']}",
                      style: Theme.of(context).textTheme.title),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
                  margin: EdgeInsets.all(0.0),
                ),
              ],
            ),
          );
        } else {
          return new Center(child: CircularProgressIndicator());
        }
      });
}

List<DonorInfo> bloodRequests = new List<DonorInfo>();

Future<List<DonorInfo>> getNotifications() async {
//  bloodRequests.remove({});
//  FirebaseUser user = await auth.currentUser();
  if (!(bloodRequests.length > 0)) {
    FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(user.uid)
        .child("request")
        .once()
        .then((DataSnapshot req) {
      Map<dynamic, dynamic> keys = req.value;
      for (var key in keys.values) {
        print("Key" + key.toString()); // good here
        FirebaseDatabase.instance
            .reference()
            .child("Users")
            .child(key)
            .once()
            .then((DataSnapshot snap) {
          var data = snap.value;
          print("Inside loop!!" + data.toString());
          print("data[full name]!!" + data['Full Name'].toString());
          DonorInfo d = new DonorInfo(
              data['Full Name'], data['BloodGroup'], data['Phone']);
          bloodRequests.add(d);
        });
      }
    });
  }
  return bloodRequests;
}

Widget notification() {
  return new FutureBuilder(
      future: getNotifications(),
      builder: (BuildContext context, AsyncSnapshot<List<DonorInfo>> Requests) {
        print("notification Widget!!!" + bloodRequests.isEmpty.toString());
//        bloodRequests.forEach((r) {
//          print(r);
//        });
        if (Requests.hasData && (bloodRequests.length > 0)) {
//          print("Requests has data !!!");
//          Requests.data.forEach((abc){
//            print(abc);
//          });
          return new Container(
//                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
              child: new Column(
            children: <Widget>[
              new Container(
                  padding: EdgeInsets.all(5.0),child: new Text(
                "Following Donors are willing to donate",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
//                style: new TextStyle(fontSize: 18.0),
              )),
              new Expanded(
                  child: new ListView.builder(
                itemCount: Requests.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return showRequests(context, bloodRequests[index].name,
                      bloodRequests[index].group, bloodRequests[index].num);
                },
              ))
            ],
          ));
        } else {
          return new Center(child: CircularProgressIndicator());
        }
      });
}

Widget showRequests(
    BuildContext context, String name, String group, String num) {
  return new Card(
    elevation: 10.0,
    child: new Container(
      padding: new EdgeInsets.all(20.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'Name : $name',
            style: Theme.of(context).textTheme.title,
          ),
          new Text('Blood Group : $group'),
          new Text('Phone Number : $num'),
//            new FlatButton(
//              onPressed: () => Alert(num),
//              child: new Text("DONATE",
//                style: new TextStyle(
//                  fontSize: 16,
//                  color: Colors.green[400],
//                ),
//              ),
//            )
        ],
      ),
    ),
  );
}

class Notification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Notifications"),
        centerTitle: true,
      ),
      body: notification(),
    );
  }
}
