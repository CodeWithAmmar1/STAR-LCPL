
import 'package:app/dialog/QReport.dart';
import 'package:app/dialog/shiftchangerequest.dart';
import 'package:app/screens/canfeedback.dart';
import 'package:app/screens/carfeedback.dart';
import 'package:app/view/QrGenerator.dart';
import 'package:app/view/inOut.dart';
import 'package:app/view/loginPage.dart';
import 'package:app/view/selectarea.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


late SharedPreferences sharedPrefs;

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  late SharedPreferences sharedPreferences;
  String userid = '';
  String unam = '';
  String cellno = '';
  String areacat = '';
  String area = '';
  String resp = '';
  List<String> QrAllowed = ['BJ01', 'MAH2', 'SO01', 'TO01'];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      userid = sharedPrefs.getString('userid') ?? '';
      unam = sharedPrefs.getString('username') ?? '';
      cellno = sharedPrefs.getString('cellno') ?? '';
      area = sharedPrefs.getString('area') ?? '';
      areacat = sharedPrefs.getString('areacat') ?? '';
      resp = sharedPrefs.getString('resp') ?? '';
      // propic = sharedPrefs.getString('userprofilepic');
    });
    // checkLoginStatus();
  }

  Widget build(BuildContext context) {
    return Drawer(
      key: _scaffoldKey,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.black45,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/login.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Text(unam,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70)),
                  Text(cellno, style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text(
              'DASHBOARD',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'SHIFT STAFF',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              if (resp == "null") {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0))),
                    content: (Row(children: <Widget>[
                      Icon(
                        Icons.warning_rounded,
                        color: Colors.red.shade700,
                      ),
                      Text("   This option only for Shift Staff")
                    ]))));
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectArea()),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.event),
            title: Text(
              'SHIFT REQUEST',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              if (resp == "null") {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0))),
                    content: (Row(children: <Widget>[
                      Icon(
                        Icons.warning_rounded,
                        color: Colors.red.shade700,
                      ),
                      Text("   This option only for Shift Staff")
                    ]))));
              } else {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return ShiftChange();
                    });
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text(
              'MESS FEEDBACK',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CanFeedback()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.commute),
            title: Text(
              'CAR FEEDBACK',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CarFeedback()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.report),
            title: Text(
              'REPORTS',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              if (resp == "null") {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0))),
                    content: (Row(children: <Widget>[
                      Icon(
                        Icons.warning_rounded,
                        color: Colors.red.shade700,
                      ),
                      Text("   This option only for Shift Staff")
                    ]))));
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Qreport()),
                );
              }
            },
          ),
// Updated By Muhammad Fahad (01-07-24 till 05-07-24)
          ListTile(
            leading: Icon(Icons.qr_code_scanner_outlined),
            title: Text(
              'QR CODE SCAN',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              if (!QrAllowed.contains(userid)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0))),
                    content: (Row(children: <Widget>[
                      Icon(
                        Icons.warning_rounded,
                        color: Colors.red.shade700,
                      ),
                      Text("   This option only for Shift Staff")
                    ]))));
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InOut()),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.qr_code_2),
            title: Text(
              'QR CODE GENERATE',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              if (!QrAllowed.contains(userid)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0))),
                    content: (Row(children: <Widget>[
                      Icon(
                        Icons.warning_rounded,
                        color: Colors.red.shade700,
                      ),
                      Text("   This option only for Shift Staff")
                    ]))));
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QrGenerator()),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text(
              'SIGNOUT',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
