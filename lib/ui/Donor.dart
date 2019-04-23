import 'dart:async';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'donation_data.dart';
//made by sateesh

class DonationData {

  String name, group, numb, qty;

  DonationData(this.name, this.group, this.numb, this.qty);
}

class UserData {

  String id, numb;

  UserData(this.id, this.numb);
}

class Donor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DonorState();
  }
}

class DonorState extends State<Donor> {
  List<DonationData> alldata = [];
  List<UserData> userdata = [];

  @override
  void initState() {

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child("RequiredBlood").once().then((DataSnapshot snap){

      var keys = snap.value.keys;
      var data = snap.value;
      alldata.clear();
      for(var key in keys) {
        DonationData d = new DonationData(
            data[key]['Full name'],
            data[key]['Blood Group'],
            data[key]['Phone num'],
            data[key]['Quantity']
        );
        alldata.add(d);
      }
      getdata();
      setState(() {
      });
    });
  }

  Future<String> getdata() async {

    String id;
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child("Users").once().then((DataSnapshot snap){

      var keys = snap.value.keys;
      var data = snap.value;
      userdata.clear();
      for(var key in keys) {
        id = key;
        UserData d = new UserData(
            id,
            data[key]['Phone']
        );
        userdata.add(d);
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Your Donation Will Save a Life"),
      ),
      body: new Container(
          child: alldata.length == 0
              ? new Text('Loading... ')
              : new ListView.builder(
            itemCount: alldata.length,
            itemBuilder: (_, index) {
              return UI(
                  alldata[index].name,
                  alldata[index].group,
                  alldata[index].numb,
                  alldata[index].qty
              );
            },
          )),
    );
  }

  Widget UI(String name, String group, String numb, String qty) {
    return new Card(
      elevation: 10.0,
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('Name : $name',style: Theme.of(context).textTheme.title,),
            new Text('Blood Group : $group'),
            new Text('Phone Number : $numb'),
            new Text('Quantity: $qty'),
            new FlatButton(
              onPressed: () => Alert(numb),
              child: new Text("DONATE",
                style: new TextStyle(
                  fontSize: 16,
                  color: Colors.green[400],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Alert(String numb) async {

    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    String donorid = user.uid;
    var recvngid;

    for (int i = 0; i < userdata.length; i++) {
      if (userdata[i].numb == numb) {
        recvngid = userdata[i].id;
        break;
      }
    }

    FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(recvngid)
        .child('request').push().set(donorid);

    var response = await FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(recvngid)
        .child('request')
        .once();
  }
}