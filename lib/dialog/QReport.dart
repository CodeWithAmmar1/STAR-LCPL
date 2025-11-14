import 'package:app/tabs/Qtab.dart';
import 'package:app/view/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

late SharedPreferences sharedPrefs;

class Qreport extends StatefulWidget {
  @override
  _Qreport createState() => _Qreport();
}

class _Qreport extends State<Qreport> {
  // ignore: deprecated_member_use
  List data1 = [];
  List<String> selected = [];
  var data2;
  String selecteName = 'ALL';
  var shiftname = '';
  var ushiftid = '';
  var _currentItemSelected = 'ALL';

  late String fdate;
  late String tdate;
  late String fshift;
  late String farea;

  Future getAllShifts() async {
    var response = await http.get(
        Uri.parse("http://144.126.197.51:5000/shift/Y"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data1 = jsonData;
    });
    return "success";
  }

  Future<void> setData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('fdate', fdate);
    sharedPreferences.setString('tdate', tdate);
    sharedPreferences.setString('farea', farea);
    sharedPreferences.setString('fshift', fshift);
    dates();
    sharedPreferences.setStringList('selected', selected);
    print(fdate);
    print(tdate);
    print(farea);
    print(fshift);
    print(selected);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Qtab()),
    );
  }

  @override
  void initState() {
    super.initState();
    getAllShifts();
  }

  var _area = [
    'ALL',
    'ELECTRICAL',
    'MECHANICAL',
    'OX',
    'HR & ADMINISTRATION',
    'PURE',
    'LAB',
    'INSTRUMENT',
    'COGEN',
    'UTILITY'
  ];

  DateTime _currentdate = DateTime.now();
  DateTime _currentdate1 = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    String _formatdate = DateFormat("dd-MMM-yyyy").format(_currentdate);
    String _formatdate1 = DateFormat("dd-MMM-yyyy").format(_currentdate1);
    _formatdate = _formatdate.toUpperCase();
    _formatdate1 = _formatdate1.toUpperCase();
    fdate = _formatdate.toString();
    tdate = _formatdate1.toString();
    farea = _currentItemSelected;
    fshift = selecteName;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Report Parameters',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.red.shade900,
      ),
      body: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 8,
          child: Container(
            padding: EdgeInsets.all(16),
            height: 400,
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Select Parameters',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50.0,
                  // color: Colors.blue,
                  padding: EdgeInsets.only(top: 0, left: 60, right: 30),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Date From: $_formatdate'),
                      ),
                      Expanded(
                        child: IconButton(
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
                                  fdate = _formatdate.toString();
                                  print(fdate);
                                });
                              },
                            );
                          },
                          icon: Icon(
                            Icons.date_range,
                            size: 30,
                            color: Colors.cyan,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50.0,
                  // color: Colors.blue,
                  padding: EdgeInsets.only(top: 0, left: 60, right: 30),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Date To:      $_formatdate1'),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            CupertinoRoundedDatePicker.show(
                              context,
                              fontFamily: "Mali",
                              initialDatePickerMode:
                                  CupertinoDatePickerMode.date,
                              minimumYear: 2000,
                              maximumYear: 3022,
                              onDateTimeChanged: (dateTime1) {
                                setState(() {
                                  _currentdate1 = dateTime1;
                                });
                              },
                            );
                          },
                          icon: Icon(
                            Icons.date_range,
                            size: 30,
                            color: Colors.cyan,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50.0,
                    padding: EdgeInsets.only(left: 20, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: .5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text('Select Area : '),
                        DropdownButton<String>(
                          items: _area.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValueSelected) {
                            setState(() {
                              this._currentItemSelected =
                                  newValueSelected ?? '';
                            });
                          },
                          value: _currentItemSelected,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50.0,
                    // color: Colors.blue,
                    padding: EdgeInsets.only(left: 80, right: 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: .5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text('Select Shift : '),
                        DropdownButton(
                          iconSize: 20,
                          hint: Text(
                            selecteName,
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          elevation: 5,
                          items: data1.map(
                            (list) {
                              return DropdownMenuItem(
                                child: Text(
                                  list['NAME'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                value: list['NAME'],
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              selecteName = value.toString();
                              // ushiftname = value;
                            });
                          },
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 30.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            setData();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomePage()),
                                (Route<dynamic> route) => false);
                          },
                          child: Text('Submit'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomePage()),
                                (Route<dynamic> route) => false);
                          },
                          child: Text('Cancel'),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dates() {
    var dateformat;
    DateTime startDate =
        new DateTime(_currentdate.year, _currentdate.month, _currentdate.day);
    DateTime endDate = new DateTime(
        _currentdate1.year, _currentdate1.month, _currentdate1.day + 1);
    List<DateTime> days = [];
    // List<String> links = [];
    DateTime tmp = DateTime(startDate.year, startDate.month, startDate.day, 12);
    while (DateTime(tmp.year, tmp.month, tmp.day) != endDate) {
      dateformat = formatDate(
          DateTime(tmp.year, tmp.month, tmp.day), [dd, '-', M, '-', yyyy]);
      selected.add(dateformat.toString().toUpperCase());
      days.add(DateTime(tmp.year, tmp.month, tmp.day));
      // print(Selected);
      tmp = tmp.add(new Duration(days: 1));
    }
    print(selected);
  }
}
