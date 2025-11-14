import 'package:app/dialog/customdialog.dart';
import 'package:app/ui/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPrefs;

class CanFeedback extends StatefulWidget {
  @override
  CanFeedbackwidget createState() => CanFeedbackwidget();
}

String radioButtonFoodDelivery = 'In-time';
int id = 3;

String radioButtonAmbiance = 'Good';
int id1 = 3;

String radioButtonFoodQuality = 'Good';
int id2 = 3;

String radioButtonServiceQuality = 'Good';
int id3 = 3;

String radioButtonCLeanLiness = 'Good';
int id4 = 3;

String radioButtonStaffCourtesy = 'Good';
int id5 = 3;

String radioButtonStaffHygiene = 'Good';
int id6 = 3;

DateTime _currentdate = DateTime.now();
DateTime _visitdate = DateTime.now();

class CanFeedbackwidget extends State {
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _suggestion = TextEditingController();
  TextEditingController _visit = TextEditingController();
  var _currentItemSelected = 'Admin';
  var _currentItemSelected1 = 'Main Mess';
  var _currentItemSelected2 = 'Lunch';

  // @override

  var _department = [
    'Admin',
    'IT',
    'IR',
    'HR',
    'Manufacturing',
    'Executive',
    'HSE',
    'Production',
    'Technical',
    'Commercial',
    'Finance'
  ];

  var _mess = [
    'Main Mess',
    'OCR Mess',
    'Recreation Hall   ',
    'City Office Mess'
  ];

  var _lunch = ['Lunch', 'Breakfast', 'Dinner', 'Tea/Coffee      '];

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    String _formatdate = DateFormat("dd-MMM-yyyy").format(_currentdate);
    String _formatdate1 = DateFormat("dd-MMM-yyyy").format(_visitdate);
    _formatdate = _formatdate.toUpperCase();
    _formatdate1 = _formatdate1.toUpperCase();
    String VISITDATE = '';
    String STAFFNO = '';
    String STAFFNAME = '';
    String DEPARTMENT = _currentItemSelected;
    String VISITTIME = '';
    String LOCATION = _currentItemSelected1;
    String CATEGORY = _currentItemSelected2;
    String FOODDELIVERY = radioButtonFoodDelivery;
    String AMBIANCE = radioButtonAmbiance;
    String FOODQUALITY = radioButtonFoodQuality;
    String SERVICEQUALITY = radioButtonServiceQuality;
    String CLEANLINESS = radioButtonCLeanLiness;
    String STAFFCOURTESY = radioButtonStaffCourtesy;
    String STAFFHYGIENE = radioButtonStaffHygiene;
    String OTHERCOMMENT = '';
    String CREATEDATE = '';
    String CURRENTDATE = '';
    String CREATEBY = '';
    CURRENTDATE = DateFormat("dd-MMM-yyyy").format(_currentdate).toUpperCase();
    CREATEDATE = DateFormat("dd-MMM-yyyy").format(DateTime.now()).toUpperCase();
    VISITDATE = DateFormat("dd-MMM-yyyy").format(_visitdate).toUpperCase();
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
          'Mess Feedback',
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 4,
                        ),
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
                                        CURRENTDATE = _currentdate.toString();
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
                        // SizedBox(
                        //   width: 5,
                        // ),
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
                              if (value?.isEmpty ?? true) {
                                return "Name can't be empty";
                              } else {
                                STAFFNAME = value!;
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
                                    items: _department
                                        .map((String dropDownStringItem) {
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
                          decoration: myBoxDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Visit: $_formatdate1',
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
                                        _visitdate = dateTime;
                                        VISITDATE = _visitdate.toString();
                                      });
                                    },
                                  );
                                },
                                padding: EdgeInsets.only(bottom: 3, right: 35),
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
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: TextFormField(
                            controller: _visit,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return "Time can't be empty";
                              } else {
                                VISITTIME = value!;
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
                              labelText: "Vist Time",
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
                                        _mess.map((String dropDownStringItem) {
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
                                        _lunch.map((String dropDownStringItem) {
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
                                    onChanged: (String? newValueSelected2) {
                                      setState(() {
                                        this._currentItemSelected2 =
                                            newValueSelected2 ?? '';
                                        print(this._currentItemSelected2);
                                      });
                                    },
                                    value: _currentItemSelected2,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
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
                            'Food Delivery',
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
                      padding: EdgeInsets.only(left: 70),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Very Late',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              'Late',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'In-Time',
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
                      padding: EdgeInsets.only(left: 80),
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
                                    radioButtonFoodDelivery = 'Very Late';
                                    FOODDELIVERY = radioButtonFoodDelivery;
                                    id = 1;
                                    print(radioButtonFoodDelivery);
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
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonFoodDelivery = 'Late';
                                    FOODDELIVERY = radioButtonFoodDelivery;
                                    id = 2;
                                    print(radioButtonFoodDelivery);
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
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonFoodDelivery = 'In-Time';
                                    FOODDELIVERY = radioButtonFoodDelivery;
                                    id = 3;
                                    print(radioButtonFoodDelivery);
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
                            'Ambiance',
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
                                groupValue: id1,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonCLeanLiness = 'Below Average';
                                    CLEANLINESS = radioButtonCLeanLiness;
                                    id1 = 1;
                                    print(radioButtonCLeanLiness);
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
                                groupValue: id1,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonCLeanLiness = 'Average';
                                    CLEANLINESS = radioButtonCLeanLiness;
                                    id1 = 2;
                                    print(radioButtonCLeanLiness);
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
                                groupValue: id1,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonCLeanLiness = 'Good';
                                    CLEANLINESS = radioButtonCLeanLiness;
                                    id1 = 3;
                                    print(radioButtonCLeanLiness);
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
                                groupValue: id1,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonCLeanLiness = 'Excellent';
                                    CLEANLINESS = radioButtonCLeanLiness;
                                    id1 = 4;
                                    print(radioButtonCLeanLiness);
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
                            'Food Quality',
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
                                groupValue: id2,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonFoodQuality = 'Below Average';
                                    FOODQUALITY = radioButtonFoodQuality;
                                    id2 = 1;
                                    print(radioButtonFoodQuality);
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
                                groupValue: id2,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonFoodQuality = 'Average';
                                    FOODQUALITY = radioButtonFoodQuality;
                                    id2 = 2;
                                    print(radioButtonFoodQuality);
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
                                groupValue: id2,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonFoodQuality = 'Good';
                                    FOODQUALITY = radioButtonFoodQuality;
                                    id2 = 3;
                                    print(radioButtonFoodQuality);
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
                                groupValue: id2,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonFoodQuality = 'Excellent';
                                    FOODQUALITY = radioButtonFoodQuality;
                                    id2 = 4;
                                    print(radioButtonFoodQuality);
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
                            'Service Quality',
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
                                    radioButtonServiceQuality = 'Below Average';
                                    SERVICEQUALITY = radioButtonServiceQuality;
                                    id3 = 1;
                                    print(radioButtonServiceQuality);
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
                                    radioButtonServiceQuality = 'Average';
                                    SERVICEQUALITY = radioButtonServiceQuality;
                                    id3 = 2;
                                    print(radioButtonServiceQuality);
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
                                    radioButtonServiceQuality = 'Good';
                                    SERVICEQUALITY = radioButtonServiceQuality;
                                    id3 = 3;
                                    print(radioButtonServiceQuality);
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
                                    radioButtonServiceQuality = 'Excellent';
                                    SERVICEQUALITY = radioButtonServiceQuality;
                                    id3 = 4;
                                    print(radioButtonServiceQuality);
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
                                groupValue: id4,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonCLeanLiness = 'Below Average';
                                    CLEANLINESS = radioButtonCLeanLiness;
                                    id4 = 1;
                                    print(radioButtonCLeanLiness);
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
                                    radioButtonCLeanLiness = 'Average';
                                    CLEANLINESS = radioButtonCLeanLiness;
                                    id4 = 2;
                                    print(radioButtonCLeanLiness);
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
                                    radioButtonCLeanLiness = 'Good';
                                    CLEANLINESS = radioButtonCLeanLiness;
                                    id4 = 3;
                                    print(radioButtonCLeanLiness);
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
                                    radioButtonCLeanLiness = 'Excellent';
                                    CLEANLINESS = radioButtonCLeanLiness;
                                    id4 = 4;
                                    print(radioButtonCLeanLiness);
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
                            'Staff Courtesy',
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
                                groupValue: id5,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonStaffCourtesy = 'Below Average';
                                    STAFFCOURTESY = radioButtonStaffCourtesy;
                                    id5 = 1;
                                    print(radioButtonStaffCourtesy);
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
                                    radioButtonStaffCourtesy = 'Average';
                                    STAFFCOURTESY = radioButtonStaffCourtesy;
                                    id5 = 2;
                                    print(radioButtonStaffCourtesy);
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
                                    radioButtonStaffCourtesy = 'Good';
                                    STAFFCOURTESY = radioButtonStaffCourtesy;
                                    id5 = 3;
                                    print(radioButtonStaffCourtesy);
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
                                    radioButtonStaffCourtesy = 'Excellent';
                                    STAFFCOURTESY = radioButtonStaffCourtesy;
                                    id5 = 4;
                                    print(radioButtonStaffCourtesy);
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
                            'Staff Hygiene',
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
                                groupValue: id6,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonStaffHygiene = 'Below Average';
                                    STAFFHYGIENE = radioButtonStaffHygiene;
                                    id6 = 1;
                                    print(radioButtonStaffHygiene);
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
                                groupValue: id6,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonStaffHygiene = 'Average';
                                    STAFFHYGIENE = radioButtonStaffHygiene;
                                    id6 = 2;
                                    print(radioButtonStaffHygiene);
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
                                groupValue: id6,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonStaffHygiene = 'Good';
                                    STAFFHYGIENE = radioButtonStaffHygiene;
                                    id6 = 3;
                                    print(radioButtonStaffHygiene);
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
                                groupValue: id6,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonStaffHygiene = 'Excellent';
                                    STAFFHYGIENE = radioButtonStaffHygiene;
                                    id6 = 4;
                                    print(radioButtonStaffHygiene);
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
                                OTHERCOMMENT = value ?? '';
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
                              backgroundColor: Colors.red.shade900,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            onPressed: () async {
                              if (_globalkey.currentState!.validate()) {
                                Map<String, String> data = {
                                  "VISITDATE": VISITDATE,
                                  "STAFFNO": STAFFNO,
                                  "STAFFNAME": STAFFNAME.toUpperCase(),
                                  "DEPARTMENT": DEPARTMENT.toUpperCase(),
                                  "VISITTIME": VISITTIME.toUpperCase(),
                                  "LOCATION": LOCATION.toUpperCase(),
                                  "CATEGORY": CATEGORY.toUpperCase(),
                                  "FOODDELIVERY": FOODDELIVERY.toUpperCase(),
                                  "AMBIANCE": AMBIANCE.toUpperCase(),
                                  "FOODQUALITY": FOODQUALITY.toUpperCase(),
                                  "SERVICEQUALITY":
                                      SERVICEQUALITY.toUpperCase(),
                                  "CLEANLINESS": CLEANLINESS.toUpperCase(),
                                  "STAFFCOURTESY": STAFFCOURTESY.toUpperCase(),
                                  "STAFFHYGIENE": STAFFHYGIENE.toUpperCase(),
                                  "OTHERCOMMENT": OTHERCOMMENT.toUpperCase(),
                                  "CREATEDATE": CREATEDATE,
                                  "CREATEBY": CREATEBY
                                };
                                var body = json.encode(data);
                                var response = await http.post(
                                    Uri.parse(
                                        "http://144.126.197.51:5000/cantfeed"),
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
                                // return json.decode(response.body);
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
