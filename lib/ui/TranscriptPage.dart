import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  String _BloodGrp, _Priority;
  String _Qty;
  int _PayValue;

  MyHomePage(this._Qty, this._BloodGrp);

  @override
  _MyHomePageState createState() => new _MyHomePageState(_Qty, _BloodGrp,);
}

class _MyHomePageState extends State<MyHomePage> {

  String _BloodGrp, _Qty, _Priority,fullname,phoneNum;
  int _PayValue;
  _MyHomePageState( this._Qty, this._BloodGrp,);

  final DatabaseReference database = FirebaseDatabase.instance.reference().child("RequiredBlood");
  final reqBloodReference = FirebaseDatabase.instance.reference().child("RequiredBlood");

  StreamSubscription<Event> _onRequestAdded;

  @override
  void initState() {
    super.initState();
    _onRequestAdded = reqBloodReference.onChildAdded.listen(onReqAdded);

  }
  _savedData() {
    database.push().set({
      'Blood Group': _BloodGrp,
      'Quantity': '43',
      'Full name': fullname,
      'Phone num:': '03213700598',
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.red.withOpacity(0.8)),
              clipper: getClipper(),
            ),
            Positioned(
                width: 350.0,
                top: MediaQuery.of(context).size.height / 10,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ])),
                    SizedBox(height: 90.0),
                    Text(
                      'Zayan Tharani',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 15.0),
                    new Row(
                      children: <Widget>[
                        new Text(
                          "Blood Group",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        new Text(
                          _BloodGrp,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 15.0),
                    new Row(
                      children: <Widget>[
                        new Text(
                          "Quantity",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        new Text(
                          _BloodGrp,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 15.0),
                    new Container(
                      child: new RaisedButton(
                        color: Colors.grey,
                        child: new Text(
                          "Request Blood",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: _savedData,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }



  void onReqAdded(Event event) {



  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 3);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
