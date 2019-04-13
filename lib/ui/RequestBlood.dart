import 'package:flutter/material.dart';

import 'TranscriptPage.dart';

class RequiredBlood extends StatefulWidget {
  @override
  _RequiredBloodState createState() => _RequiredBloodState();
}

class _RequiredBloodState extends State<RequiredBlood> {

  double result = 0.0;
  String finalResult = "";
  int radio = 0;
  inputChange(String val){
    setState((){
      getWeight(radio);
    });
  }
  void getWeight(val) {
    setState(() {
      radio = val;
      switch (radio) {
        case (0):
          finalResult = "Yes";

          break;
        case (1):

          finalResult = "No";

          break;
      }
    });
  }


  int _PayValue = 0;
  String _BloodGrp,_Qty,_Priority ;
  bool _Pay ;
  String _value = null;
  List<String> _values = new List<String>();
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
  String _radioValue1;
  String _handleValue;
  @override
  void initState() {
    // TODO: implement initState
    _values.addAll(["A+","A-","B+","B-","O+","O-","AB+","AB-",]);
    _value = _values.elementAt(0);
    super.initState();
  }

  void _onChanged(String value){
    setState(() {
      _value = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Request Blood'),
      ),
      body: new SingleChildScrollView(
        child: new Form(
            key: _formkey,
            child: new Theme(
                data: new ThemeData(
                  //  brightness: Brightness.dark,
                    primarySwatch: Colors.red,
                    inputDecorationTheme: new InputDecorationTheme(
                        labelStyle: new TextStyle(
                            color: Colors.red,
                            fontSize: 20.0
                        )
                    )
                ) ,
                child:
                new Container(
                  padding: const EdgeInsets.all(40.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Text("Blood Group",style: TextStyle(fontSize: 20.0,fontWeight:  FontWeight.bold),),
                          new Padding(
                              padding: const EdgeInsets.only(right: 100.0)
                          ),
                          new DropdownButton(

                              value: _value,
                              items: _values.map((String value){
                                return new DropdownMenuItem(
                                    value: value,
                                    child: new Text(value)
                                );
                              }).toList(),
                              onChanged: (String value){
                                _onChanged(value);
                                _BloodGrp = value;
                              }
                          )
                        ],
                      ),
                      new TextFormField(
                        validator: (input){
                          if(input.isEmpty){
                            return 'Please Type Bottle Quantity';
                          }
                        },
                        onSaved: (input)
                        {
                          _Qty = input;
                        },

                        decoration: new InputDecoration(
                            labelText: "Quantity",
                            fillColor: Colors.amberAccent
                        ),
                        keyboardType: TextInputType.number,
                      ),

                      new Row(

                        children: <Widget>[
                          new Text("Payment",style: TextStyle(fontSize: 20.0,fontWeight:  FontWeight.bold),),
                          new Radio<int>(
                              activeColor: Colors.green,
                              value: 0,
                              groupValue: radio,
                              onChanged: getWeight),
                          new Text(
                            "Yes",
                            style: new TextStyle(color: Colors.black),
                          ),
                          new Radio<int>(
                              activeColor: Colors.red,
                              value: 1,
                              groupValue: radio,
                              onChanged: getWeight),
                          new Text(
                            "No",
                            style: new TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      new Padding(padding: EdgeInsets.all(20.5)),

                      new Center(
                        child: Container(
                          child: new RaisedButton(
                            color: Colors.redAccent,
                            child: new Text("Request",style: TextStyle(color: Colors.white),),
                            onPressed: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>MyHomePage(_Qty, _BloodGrp)));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                          ),
                        ),
                      )

//                    new Text(
//                      finalResult,
//                      style: new TextStyle(
//                          color: Colors.red,
//                          fontSize: 19.4,
//                          fontWeight: FontWeight.w500),
//                    )

                    ],
                  ),
                ))),
      ),
    );
  }



}


