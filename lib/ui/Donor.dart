import 'dart:core';

import 'package:flutter/material.dart';


class Donor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DonorState();
  }
}

class DonorState extends State<Donor> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text("Your Donation Will Save a Life"),
        ),

            );


  }



}
