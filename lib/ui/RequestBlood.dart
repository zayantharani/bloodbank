import 'package:flutter/material.dart';

class RequestBlood extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RequestBloodState();
  }
}

class RequestBloodState extends State<RequestBlood> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Ask For Help"),
      ),
      body: new Text("fill form to request blood"),
    );
  }
}