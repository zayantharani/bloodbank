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

  String _BloodGrp,_Qty,_Priority ;



  String _value = "";
  String _PAY ="0";
  List<String> _values = ["A+","A-","B+","B-","O+","O-","AB+","AB-"];


  String _value2 = "";
  List<String> _values2 = ["1","2","3","4","5","6"];

  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();
  }

  _RequiredBloodState(){
    _BloodGrp = "A+";
    _value = "+A";
    _value = _values.elementAt(0);
    _Qty = "1";
    _value2 = "1";
    _value2 = _values2.elementAt(0);

  }
  void _onChanged(String value){
    setState(() {
      _value = value;
    });
  }
  void _onChanged2(String value){
    setState(() {
      _value2 = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Blood_drop.svg/367px-Blood_drop.svg.png',
              fit: BoxFit.scaleDown,
              ),
              Container(
                  padding: const EdgeInsets.all(15.0), child: Text('Request Blood',style: TextStyle(fontSize: 20),))
            ],
          ),
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
                      new Row(
                        children: <Widget>[
                          new Text("Quantity",style: TextStyle(fontSize: 20.0,fontWeight:  FontWeight.bold),),
                          new Padding(
                              padding: const EdgeInsets.only(right: 150.0)
                          ),
                          new DropdownButton(
                              value: _value2,
                              items: _values2.map((String value){
                                return new DropdownMenuItem(
                                    value: value,
                                    child: new Text(value)
                                );
                              }).toList(),
                              onChanged: (String value){
                                _onChanged2(value);
                                _Qty = value;
                              }
                          ),

                        ],

                      ),
                      new TextFormField(
                        textAlign: TextAlign.end,
                        onSaved: (input) => _PAY = input,
                        decoration: new InputDecoration(
                          labelText: "Payment",
                          hintText: "0",
                          contentPadding: EdgeInsets.all(10)
                        ),
                      ),
                      new Padding(padding: EdgeInsets.all(20.5)),
                      new Center(
                        child: Container(
                          child: new RaisedButton(
                            color: Colors.redAccent,
                            child: new Text("Request",style: TextStyle(color: Colors.white),),
                            onPressed: (){
                             print("BLOOD GRP = "+ _BloodGrp.toString());
                             print("Quantity = "+ _Qty.toString());

                              Navigator.push(context,MaterialPageRoute(builder: (context)=>MyHomePage(_Qty, _BloodGrp)));
                              },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                ))),
      ),
    );
  }



}
