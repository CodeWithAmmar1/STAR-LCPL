import 'package:LotteRota/dialog/customdialog.dart';
import 'package:LotteRota/ui/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPrefs;

class CarFeedback extends StatefulWidget {
  @override
  CarFeedbackwidget createState() => CarFeedbackwidget();
}

String radioButtonItem = 'Yes';
int id = 1;

String radioButtonUniform = 'Yes';
int id1 = 1;

String radioButtonPolicy = 'Yes';
int id2 = 1;

String radioButtonClean = 'Good';
int id3 = 3;

String radioButtonDriver = 'Good';
int id4 = 3;

String radioButtonOverall = 'Good';
int id5 = 3;

DateTime _currentdate = DateTime.now();

class CarFeedbackwidget extends State {
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _suggestion = TextEditingController();
  TextEditingController _route = TextEditingController();
  TextEditingController _travel = TextEditingController();
  TextEditingController _carno = TextEditingController();
  TextEditingController _driver = TextEditingController();
  var _currentItemSelected = 'Staff';
  var _currentItemSelected1 = 'Shift';

  // @override
  var _visit = [
    'Staff',
    'Visitor           ',
  ];

  var _shift = ['Shift', 'General Shift'];

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    String _formatdate = DateFormat("dd-MMM-yyyy").format(_currentdate);
    _formatdate = _formatdate.toUpperCase();
    String STAFFNO = '';
    String STAFFNAME = '';
    String TRAVELDATE = '';
    String SHIFTTYPE = _currentItemSelected1;
    String ROUTE = '';
    String STAFFTYPE = _currentItemSelected;
    String TRAVELFROMTO = '';
    String CARNO = '';
    String DRIVERNAME = '';
    String SEATBELT = radioButtonItem;
    String UNIFORM = radioButtonUniform;
    String COMPANYPOLICY = radioButtonPolicy;
    String CLEANLINESS = radioButtonClean;
    String DRIVERATTITUDE = radioButtonDriver;
    String OVERALLTRANSPORTSERVICES = radioButtonOverall;
    String OTHERCOMMENT = '';
    String CREATEDATE = '';
    String CREATEBY = '';
    CREATEDATE = DateFormat("dd-MMM-yyyy").format(DateTime.now()).toUpperCase();
    TRAVELDATE = DateFormat("dd-MMM-yyyy").format(_currentdate).toUpperCase();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      CREATEBY = sharedPrefs?.getString('userid') ?? '';
      STAFFNO = sharedPrefs?.getString('staffno') ?? '';
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Center(
            child: Text(
          'Transport Feedback',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _globalkey,
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2.2,
                          decoration: myBoxDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '   Date: $_formatdate',
                                style: TextStyle(fontSize: 12),
                              ),
                              IconButton(
                                onPressed: () {
                                  CupertinoRoundedDatePicker.show(
                                    context,
                                    fontFamily: "Mali",
                                    initialDatePickerMode:
                                        CupertinoDatePickerMode.date,
                                    minimumYear: 2000,
                                    maximumYear: 3022,
                                    onDateTimeChanged: (dateTime) {
                                      setState(() {
                                        _currentdate = dateTime;
                                        TRAVELDATE = _currentdate.toString();
                                      });
                                    },
                                  );
                                },
                                padding: EdgeInsets.only(bottom: 3, right: 15),
                                icon: Icon(
                                  Icons.date_range,
                                  size: 20,
                                  color: Colors.red.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            height: 30.0,
                            width: MediaQuery.of(context).size.width / 2.2,
                            padding: EdgeInsets.only(left: 10, right: 0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade500, width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: <Widget>[
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    iconEnabledColor: Colors.red.shade900,
                                    items: _shift
                                        .map((String dropDownStringItem1) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem1,
                                        child: Text(
                                          dropDownStringItem1,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade600),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValueSelected1) {
                                      setState(() {
                                        this._currentItemSelected1 =
                                            newValueSelected1 ?? '';
                                        print(this._currentItemSelected1);
                                      });
                                    },
                                    value: _currentItemSelected1,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: TextFormField(
                            controller: _name,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return "Name can't be empty";
                              } else {
                                STAFFNAME = value ?? '';
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 14),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(),
                              focusedBorder: new OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red.shade900),
                              ),
                              labelText: "Name",
                            ),
                            inputFormatters: [UpperCaseText()],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            height: 30.0,
                            width: MediaQuery.of(context).size.width / 2.2,
                            padding: EdgeInsets.only(left: 10, right: 0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade500, width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: <Widget>[
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    iconEnabledColor: Colors.red.shade900,
                                    items:
                                        _visit.map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(
                                          dropDownStringItem,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade600),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValueSelected) {
                                      setState(() {
                                        this._currentItemSelected =
                                            newValueSelected ?? '';
                                        print(this._currentItemSelected);
                                      });
                                    },
                                    value: _currentItemSelected,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: TextFormField(
                            controller: _route,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return "Route can't be empty";
                              } else {
                                ROUTE = value!;
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 14),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(),
                              focusedBorder: new OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red.shade900),
                              ),
                              labelText: "Route (Shift)",
                            ),
                            inputFormatters: [UpperCaseText()],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: TextFormField(
                            controller: _travel,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return "Travel can't be empty";
                              } else {
                                TRAVELFROMTO = value!;
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 14),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(),
                              focusedBorder: new OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red.shade900),
                              ),
                              labelText: "Travel from / to",
                            ),
                            inputFormatters: [UpperCaseText()],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: TextFormField(
                            controller: _carno,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return "Car No. can't be empty";
                              } else {
                                CARNO = value!;
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 14),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(),
                              focusedBorder: new OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red.shade900),
                              ),
                              labelText: "Car No.",
                            ),
                            inputFormatters: [UpperCaseText()],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: TextFormField(
                            controller: _driver,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return "Driver name can't be empty";
                              } else {
                                DRIVERNAME = value!;
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 14),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(),
                              focusedBorder: new OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red.shade900),
                              ),
                              labelText: "Driver Name",
                            ),
                            inputFormatters: [UpperCaseText()],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.grey.shade200,
                          padding: EdgeInsets.only(left: 8, top: 3),
                          height: 20,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Text(
                            'Seat Belt',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 15,
                      padding: EdgeInsets.only(left: 90),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Yes',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            Text(
                              'No',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 15,
                      padding: EdgeInsets.only(left: 78),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 1,
                                groupValue: id,
                                onChanged: (value) {
                                  setState(() {
                                    radioButtonItem = 'Yes';
                                    SEATBELT = radioButtonItem;
                                    id = 1;
                                    print(radioButtonItem);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 36,
                            ),
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 2,
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'No';
                                    SEATBELT = radioButtonItem;
                                    id = 2;
                                    print(radioButtonItem);
                                  });
                                },
                              ),
                            ),
                          ]),
                    ),
                    ////////////////////////////////////////////////////
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.grey.shade200,
                          padding: EdgeInsets.only(left: 8, top: 3),
                          height: 20,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Text(
                            'Uniform',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 15,
                      padding: EdgeInsets.only(left: 90),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Yes',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            Text(
                              'No',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 15,
                      padding: EdgeInsets.only(left: 78),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 1,
                                groupValue: id1,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonUniform = 'Yes';
                                    UNIFORM = radioButtonUniform;
                                    id1 = 1;
                                    print(radioButtonUniform);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 36,
                            ),
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 2,
                                groupValue: id1,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonUniform = 'No';
                                    UNIFORM = radioButtonUniform;
                                    id1 = 2;
                                    print(radioButtonUniform);
                                  });
                                },
                              ),
                            ),
                          ]),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.grey.shade200,
                          padding: EdgeInsets.only(left: 8, top: 3),
                          height: 20,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Text(
                            'Company Policy',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 15,
                      padding: EdgeInsets.only(left: 90),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Yes',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            Text(
                              'No',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 15,
                      padding: EdgeInsets.only(left: 78),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 1,
                                groupValue: id2,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonPolicy = 'Yes';
                                    COMPANYPOLICY = radioButtonPolicy;
                                    id2 = 1;
                                    print(radioButtonPolicy);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 36,
                            ),
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 2,
                                groupValue: id2,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonPolicy = 'No';
                                    COMPANYPOLICY = radioButtonPolicy;
                                    id2 = 2;
                                    print(radioButtonPolicy);
                                  });
                                },
                              ),
                            ),
                          ]),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.grey.shade200,
                          padding: EdgeInsets.only(left: 8, top: 3),
                          height: 20,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Text(
                            'Cleanliness',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    /////////////////////////////////////
                    Container(
                      height: 15,
                      padding: EdgeInsets.only(left: 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Below Average',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Average',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Good',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Excellent',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    ////////////////////////////////////
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 15,
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 1,
                                groupValue: id3,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonClean = 'Below Average';
                                    CLEANLINESS = radioButtonClean;
                                    id3 = 1;
                                    print(radioButtonClean);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 2,
                                groupValue: id3,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonClean = 'Average';
                                    CLEANLINESS = radioButtonClean;
                                    id3 = 2;
                                    print(radioButtonClean);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 3,
                                groupValue: id3,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonClean = 'Good';
                                    CLEANLINESS = radioButtonClean;
                                    id3 = 3;
                                    print(radioButtonClean);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 4,
                                groupValue: id3,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonClean = 'Excellent';
                                    CLEANLINESS = radioButtonClean;
                                    id3 = 4;
                                    print(radioButtonClean);
                                  });
                                },
                              ),
                            ),
                          ]),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.grey.shade200,
                          padding: EdgeInsets.only(left: 8, top: 3),
                          height: 20,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Text(
                            "Driver's Attitude",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 15,
                      padding: EdgeInsets.only(left: 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Below Average',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Average',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Good',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Excellent',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 15,
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 1,
                                groupValue: id4,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonDriver = 'Below Average';
                                    DRIVERATTITUDE = radioButtonDriver;
                                    id4 = 1;
                                    print(radioButtonDriver);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 2,
                                groupValue: id4,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonDriver = 'Average';
                                    DRIVERATTITUDE = radioButtonDriver;
                                    id4 = 2;
                                    print(radioButtonDriver);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 3,
                                groupValue: id4,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonDriver = 'Good';
                                    DRIVERATTITUDE = radioButtonDriver;
                                    id4 = 3;
                                    print(radioButtonDriver);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 4,
                                groupValue: id4,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonDriver = 'Excellent';
                                    DRIVERATTITUDE = radioButtonDriver;
                                    id4 = 4;
                                    print(radioButtonDriver);
                                  });
                                },
                              ),
                            ),
                          ]),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.grey.shade200,
                          padding: EdgeInsets.only(left: 8, top: 3),
                          height: 20,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Text(
                            "Overall Transport Service",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 15,
                      padding: EdgeInsets.only(left: 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Below Average',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Average',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Good',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Excellent',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 15,
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 1,
                                groupValue: id5,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonOverall = 'Below Average';
                                    OVERALLTRANSPORTSERVICES =
                                        radioButtonOverall;
                                    id5 = 1;
                                    print(radioButtonOverall);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 2,
                                groupValue: id5,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonOverall = 'Average';
                                    OVERALLTRANSPORTSERVICES =
                                        radioButtonOverall;
                                    id5 = 2;
                                    print(radioButtonOverall);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 3,
                                groupValue: id5,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonOverall = 'Good';
                                    OVERALLTRANSPORTSERVICES =
                                        radioButtonOverall;
                                    id5 = 3;
                                    print(radioButtonOverall);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Transform.scale(
                              scale: .85,
                              child: Radio(
                                activeColor: Colors.red.shade900,
                                value: 4,
                                groupValue: id5,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonOverall = 'Excellent';
                                    OVERALLTRANSPORTSERVICES =
                                        radioButtonOverall;
                                    id5 = 4;
                                    print(radioButtonOverall);
                                  });
                                },
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                              'Any suggestion or Comment for improvement',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width - 20,
                          child: TextFormField(
                            controller: _suggestion,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return "Suggestion can't be empty";
                              } else {
                                OTHERCOMMENT = value!;
                                return null;
                              }
                            },
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            //Normal textInputField will be displayed
                            maxLines: 3,
                            // when user presses enter it will adapt to it
                            style: TextStyle(fontSize: 14),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(),
                              focusedBorder: new OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red.shade900),
                              ),
                              labelText: "Suggestion",
                            ),
                            inputFormatters: [UpperCaseText()],
                          ),
                        ),
                      ],
                    ),
                    ///////////////////////////////////////////////////
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                Container(
                    height: 50.0,
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              backgroundColor: Colors.red.shade900,
                            ),
                            onPressed: () async {
                              if (_globalkey.currentState?.validate() ??
                                  false) {
                                Map<String, String> data = {
                                  "STAFFNO": STAFFNO,
                                  "STAFFNAME": STAFFNAME.toUpperCase(),
                                  "TRAVELDATE": TRAVELDATE,
                                  "SHIFTTYPE": SHIFTTYPE.toUpperCase(),
                                  "ROUTE": ROUTE.toUpperCase(),
                                  "STAFFTYPE": STAFFTYPE.toUpperCase(),
                                  "TRAVELFROMTO": TRAVELFROMTO.toUpperCase(),
                                  "CARNO": CARNO.toUpperCase(),
                                  "DRIVERNAME": DRIVERNAME.toUpperCase(),
                                  "SEATBELT": SEATBELT.toUpperCase(),
                                  "UNIFORM": UNIFORM.toUpperCase(),
                                  "COMPANYPOLICY": COMPANYPOLICY.toUpperCase(),
                                  "CLEANLINESS": CLEANLINESS.toUpperCase(),
                                  "DRIVERATTITUDE":
                                      DRIVERATTITUDE.toUpperCase(),
                                  "OVERALLTRANSPORTSERVICES":
                                      OVERALLTRANSPORTSERVICES.toUpperCase(),
                                  "OTHERCOMMENT": OTHERCOMMENT.toUpperCase(),
                                  "CREATEDATE": CREATEDATE,
                                  "CREATEBY": CREATEBY
                                };
                                var body = json.encode(data);
                                var response = await http.post(
                                    Uri.parse(
                                        "http://144.126.197.51:5000/carfeed"),
                                    headers: {
                                      "Content-Type": "application/json"
                                    },
                                    body: body);
                                var jsonBody = response.body;
                                var jsonData = json.decode(jsonBody);
                                print(jsonData);
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AdvanceCustomAlert();
                                    });
                                return json.decode(response.body);
                              }
                            },
                            child: Text(
                              'Submit',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.grey.shade500),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    );
  }
}
