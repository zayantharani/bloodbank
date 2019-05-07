import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:flutter/cupertino.dart';

class MyHomePage extends StatefulWidget {
  String _BloodGrp = " ";
  String _Qty = " ";
  String payment = " ";
  int BDcount;
  MyHomePage(this._Qty, this._BloodGrp,this.payment);

  @override
  _MyHomePageState createState() => new _MyHomePageState(_Qty, _BloodGrp,payment);
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime date;
  String _BloodGrp, _Qty, _Priority,fullname,phoneNum;
   String payment;
  _MyHomePageState( this._Qty, this._BloodGrp,this.payment);
  static String FName,Phone;
  String DateNow;
  int DonorCount;
  final DatabaseReference database = FirebaseDatabase.instance.reference().child("RequiredBlood");
  final DatabaseReference database2 = FirebaseDatabase.instance.reference().child("Users");
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();

    var n = getUserName();

    DateTime today = new DateTime.now();
    DateNow ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
  }

  Future<String> getUserName() async {

    final FirebaseUser user = await auth.currentUser();

    var response = await FirebaseDatabase.instance
        .reference()
        .child("Users").child(user.uid).child('Full Name')
        .once();
    var response2 = await FirebaseDatabase.instance
        .reference()
        .child("Users").child(user.uid).child('Phone')
        .once();
    var response3 = await FirebaseDatabase.instance
        .reference()
        .child("Users").child(user.uid).child('DonationCount')
        .once();

    FName = response.value.toString();
    Phone = response2.value.toString();
    DonorCount = response3.value;

  }



  _savedData() async{
    final FirebaseUser user2 = await auth.currentUser();
    print("The value is");
//    DonorCount = DonorCount + 1;
//    print(DonorCount.toString());

    database.push().set({
      'Blood Group': _BloodGrp,
      'Quantity': _Qty,
      'Full name': FName,
      'Phone num': Phone,
      'Date:' : DateNow,
      'Payment':payment,
    });

    database2.child(user2.uid).update({
      "Blood Donor Count": DonorCount,
    });

    showDialog(
        context: context,
        builder: (context) {

          return  AlertDialog(
            shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
            title: Text(_BloodGrp+" requested to Donors"),
          );
        });

//    Future.delayed(Duration(seconds: 1), () {
//        Navigator.of(context).pop(true);
//      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
//    });
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
                            color: Colors.white,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://www.law.berkeley.edu/wp-content/uploads/2015/04/Blank-profile.png'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ])),
                    SizedBox(height: 40.0),
                    Text(
                      FName,
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 15.0),
                    new Row(
                      children: <Widget>[
                        new Text(
                          "Blood Group    ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        new Text(
                          _BloodGrp,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 15.0),
                    new Row(
                      children: <Widget>[
                        new Text(
                          "Quantity   ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        new Text(
                          _Qty,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 15.0),

                    new Row(
                      children: <Widget>[
                        new Text(
                          "Phone    ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        new Text(
                          Phone,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),



                    SizedBox(height: 15.0),


                    new Row(
                      children: <Widget>[
                        new Text(
                          "Date    ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        new Text(
                          DateNow,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),



                    SizedBox(height: 15.0),

                    new Row(
                      children: <Widget>[
                        new Text(
                          "Payment    ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        new Text(
                          payment,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),


                    SizedBox(height: 25.0),



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
