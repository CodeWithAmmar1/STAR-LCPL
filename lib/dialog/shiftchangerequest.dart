import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

late SharedPreferences sharedPrefs;

class ShiftChange extends StatefulWidget {
  @override
  _ShiftChange createState() => _ShiftChange();
}

final Color textColor = Colors.white.withOpacity(0.4);

class _ShiftChange extends State<ShiftChange> {
  DateTime _currentdate = DateTime.now();
  var changedate;
  var _currentItemSelected1 = 'Shift to Change';
  var _currentItemSelected2 = 'Current Shift';
  var createdby;
  late String emp;
  late int empno;
  late String username;
  late String cellno;
  late String mgrcellno;
  late String mgrno;
  late String staffno;
  var data5;
  var todaydate;

  // ignore: deprecated_member_use
  List shiftfrom = [];

  // ignore: deprecated_member_use
  List shiftto = [];

  Future getAllShifts() async {
    var response = await http.get(
        Uri.parse("http://144.126.197.51:5000/shift/Y"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      shiftfrom = jsonData;
      shiftto = jsonData;
    });
    // getPref();
    getShiftChange();
    return "success";
  }

  Future getSms() async {
    var response = await http.get(
        Uri.parse("http://144.126.197.51:5000/getsms"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    print(jsonData);
    data5 = jsonData['results'][0];
    if (data5 == null) {
      data5 = 1;
    } else {
      data5 = data5 + 1;
    }
    print("SMS Serial = $data5");
    // addSms();
    return "success";
  }

  Future addSms() async {
    todaydate = DateTime.now();
    todaydate = formatDate(todaydate, [dd, '-', M, '-', yyyy]);
    todaydate = todaydate.toString().toUpperCase();

    var COMPNO = data5;
    String CELLNO = mgrcellno;
    String MSG =
        "Sir, I ( $username, Cell no. $cellno ) would request you to change my shift from " +
            _currentItemSelected2 +
            " to " +
            _currentItemSelected1 +
            " of $changedate " +
            ". Thanks ";
    String MASK = 'LCPL Admin';
    String TRANSFEREDDATE = todaydate;

    Map datae = {
      'COMPNO': COMPNO,
      'CELLNO': CELLNO,
      'MSG': MSG,
      'MASK': MASK,
      'TRANSFEREDDATE': TRANSFEREDDATE
      // 'password': pass,
      // 'roles': roles,
    };

    var body = json.encode(datae);
    var response = await http.post(
        Uri.parse("http://144.126.197.51:5000/addsms"),
        headers: {"Content-Type": "application/json"},
        body: body);
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    addCustShift();
    return json.decode(response.body);
  }

  Future getShiftChange() async {
    var response = await http.get(
        Uri.parse("http://144.126.197.51:5000/shiftrequest/$empno"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      mgrcellno = jsonData[0]['MGR_CELLNO'];
      mgrno = jsonData[0]['MGR_NO'];
    });
    getSms();
    return "success";
    }

  Future addCustShift() async {
    Map<String, String> data = {
      "STAFFNO": staffno,
      "CHANGESHIFTDATE": changedate.toString().toUpperCase(),
      "CURRENTSHIFTNAME": _currentItemSelected2,
      "REQUESTSHIFTNAME": _currentItemSelected1,
      "REPORTINGMGRNO": mgrno,
      "CREATEDATE": todaydate.toString().toUpperCase(),
      "CREATEBY": createdby,
    };
    var body = json.encode(data);
    var response = await http.post(
        Uri.parse("http://144.126.197.51:5000/custshiftrequest"),
        headers: {"Content-Type": "application/json"},
        body: body);
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(jsonData);
  }

  UniqueKey key = UniqueKey();
  @override
  void initState() {
    this.getAllShifts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      createdby = sharedPrefs.getString('userid');
      username = sharedPrefs.getString('username') ?? '';
      cellno = sharedPrefs.getString('cellno') ?? '';
      emp = sharedPrefs.getString('staffno') ?? '';
      staffno = sharedPrefs.getString('staffno') ?? '';
      empno = int.parse(emp);
    });
    String _formatdate = DateFormat("dd-MMM-yyyy").format(_currentdate);
    Size size = MediaQuery.of(context).size;
    double contWidth = size.width * 0.85;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        child: Center(
          child: FrostedGlassBox(
            width: size.width * 0.90,
            height: contWidth / 1.2,
            key: key,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Shift Change Request",
                      style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.6),
                              blurRadius: 3.0,
                              color: Color.fromARGB(100, 0, 0, 0),
                            ),
                          ],
                          color: Colors.red.shade900,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.red.shade900,
                      endIndent: 22,
                      indent: 22,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2.8,
                          decoration: myBoxDecoration(),
                          child: Text(
                            username,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 6),
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2.8,
                          decoration: myBoxDecoration(),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '$_formatdate',
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
                                      (context as Element).markNeedsBuild();
                                      _currentdate = dateTime;
                                      changedate = formatDate(_currentdate,
                                          [dd, '-', M, '-', yyyy]);
                                    },
                                  );
                                },
                                padding: EdgeInsets.only(left: 30, bottom: 3),
                                icon: Icon(
                                  Icons.date_range,
                                  size: 18,
                                  color: Colors.red.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(left: 6, bottom: 2, right: 18),
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2.8,
                          decoration: myBoxDecoration(),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              iconEnabledColor: Colors.red.shade900,
                              iconSize: 25,
                              hint: Text(
                                _currentItemSelected2,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              items: shiftfrom.map(
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
                                  _currentItemSelected2 = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 6, bottom: 2, right: 18),
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2.8,
                          decoration: myBoxDecoration(),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              iconEnabledColor: Colors.red.shade900,
                              iconSize: 25,
                              hint: Text(
                                _currentItemSelected1,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              items: shiftto.map(
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
                                  _currentItemSelected1 = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
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
                                addSms();
                                Navigator.pop(context);
                                showAlertDialog(context);
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
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
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
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Text("Success"),
    content: Text("Record Saved successfully"),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(width: 1.0, color: Colors.grey.shade500),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  );
}

class FrostedGlassBox extends StatelessWidget {
  final double width, height;
  final Widget child;

  const FrostedGlassBox(
      {required Key key,
      required this.width,
      required this.height,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            // BackdropFilter(
            //   filter: ImageFilter.blur(
            //     sigmaX: 7.0,
            //     sigmaY: 7.0,
            //   ),
            // child: Container(width: width, height: height, child: Text(" ")),
            // ),
            // Opacity(
            //     opacity: 0.15,
            //     child: Image.asset(
            //       "assets/images/noise.png",
            //       fit: BoxFit.cover,
            //       width: width,
            //       height: height,
            //     )),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Colors.black.withOpacity(0.25),
                  //       blurRadius: 30,
                  //       offset: Offset(2, 2))
                  // ],
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.2), width: 1.0),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Colors.white,
                      ],
                      stops: [
                        0.0,
                        1.0,
                      ])),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
