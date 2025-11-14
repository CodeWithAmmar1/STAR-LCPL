import 'dart:ui';
import 'package:app/Icons/IconsSVG.dart';
import 'package:app/Model/TabIconData.dart';
import 'package:app/dialog/QReport.dart';
import 'package:app/dialog/shiftchangerequest.dart';
import 'package:app/screens/canfeedback.dart';
import 'package:app/screens/carfeedback.dart';
import 'package:app/view/QrGenerator.dart';
import 'package:app/view/loginPage.dart';
import 'package:app/view/main_drawer.dart';
import 'package:app/view/selectarea.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'inOut.dart';

SharedPreferences? sharedPrefs;
final scaffoldKeyGlobal = GlobalKey<ScaffoldState>();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController animationController;
  late SharedPreferences sharedPreferences;
  var userid = '';
  var unam = '';
  var cellno = '';
  var area = '';
  var areacat = '';
  var resp = '';
  List<String> QrAllowed = ['BJ01', 'MAH2', 'SO01', 'TO01'];

  @override
  void initState() {
    super.initState();
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      userid = sharedPrefs?.getString('userid') ?? '';
      unam = sharedPrefs?.getString('username') ?? '';
      cellno = sharedPrefs?.getString('cellno') ?? '';
      area = sharedPrefs?.getString('area') ?? '';
      areacat = sharedPrefs?.getString('areacat') ?? '';
      resp = sharedPrefs?.getString('resp') ?? '';
      // propic = sharedPrefs.getString('userprofilepic');
    });
    // checkLoginStatus();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red.shade700,
        title:
            Text("LOTTE Chemical Pak. ", style: TextStyle(color: Colors.white)),
        // actions: [
        //   Stack(
        //     children: [
        //       IconButton(
        //           icon: Icon(
        //             Icons.notifications,
        //             color: Colors.white,
        //           ),
        //           onPressed: () {}),
        //       Positioned(
        //         top: 0,
        //         right: 6,
        //         child: Container(
        //           padding: EdgeInsets.all(4),
        //           decoration: BoxDecoration(
        //               color: Colors.yellow, shape: BoxShape.circle),
        //           child: Text(
        //             '0',
        //             style: TextStyle(fontSize: 14, color: Colors.red[600]),
        //           ),
        //         ),
        //       ),
        //     ],
        //   )
        // ],
      ),
      drawer: MainDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SvgPicture.asset(
              background1,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "  Configured by Ali Ammar \naliammar0342@gmail.com",
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  Text(
                    "DASHBOARD",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Welcome, " + unam,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: GestureDetector(
                            onTap: () {
                              if (resp == "null") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    new SnackBar(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16.0),
                                                topRight:
                                                    Radius.circular(16.0))),
                                        content: (Row(children: <Widget>[
                                          Icon(
                                            Icons.warning_rounded,
                                            color: Colors.red.shade700,
                                          ),
                                          Text(
                                              "   This option only for Shift Staff")
                                        ]))));
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectArea()),
                                );
                              }
                            },
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0xff8E8FC9).withOpacity(0.3)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(Staff),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Shift Staff",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: GestureDetector(
                            onTap: () {
                              if (resp == "null") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    new SnackBar(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16.0),
                                                topRight:
                                                    Radius.circular(16.0))),
                                        content: (Row(children: <Widget>[
                                          Icon(
                                            Icons.warning_rounded,
                                            color: Colors.red.shade700,
                                          ),
                                          Text(
                                              "   This option only for Shift Staff")
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
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0xff8E8FC9).withOpacity(0.3)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(ShiftRequest),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Shift Request",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ///////////////////////////////////////////////////////////////////////////////////////
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CanFeedback()),
                              );
                            },
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0xff8E8FC9).withOpacity(0.3)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(FoodFeedbackImage),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Mess Feedback",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CarFeedback()),
                              );
                            },
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0xff8E8FC9).withOpacity(0.3)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(CarFeedbackImage),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Car Feedback",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: GestureDetector(
                            onTap: () {
                              if (!QrAllowed.contains(userid)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    new SnackBar(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16.0),
                                                topRight:
                                                    Radius.circular(16.0))),
                                        content: (Row(children: <Widget>[
                                          Icon(
                                            Icons.warning_rounded,
                                            color: Colors.red.shade700,
                                          ),
                                          Text(
                                              "   This option only for Administration")
                                        ]))));
                                return;
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => InOut()),
                              );
                            },
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0xff8E8FC9).withOpacity(0.3)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // SvgPicture.asset(Reports),
                                  Container(
                                    width: 70,
                                    height: 70,
                                    child: ClipOval(
                                      child: CircleAvatar(
                                        child: Image(
                                            image: AssetImage(
                                                "assets/icons/qr_magnify.png")),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "QR Code Scan",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: GestureDetector(
                            onTap: () {
                              if (!QrAllowed.contains(userid)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    new SnackBar(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16.0),
                                                topRight:
                                                    Radius.circular(16.0))),
                                        content: (Row(children: <Widget>[
                                          Icon(
                                            Icons.warning_rounded,
                                            color: Colors.red.shade700,
                                          ),
                                          Text(
                                              "   This option only Administration")
                                        ]))));
                                return;
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => QrGenerator()),
                              );
                            },
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0xff8E8FC9).withOpacity(0.3)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // SvgPicture.asset(Reports),
                                  Container(
                                    width: 70,
                                    height: 70,
                                    child: ClipOval(
                                      child: CircleAvatar(
                                        child: Image(
                                            image: AssetImage(
                                                "assets/icons/qr_scan.png")),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "QR Code Gen",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: GestureDetector(
                            onTap: () {
                              if (resp == "null") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    new SnackBar(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16.0),
                                                topRight:
                                                    Radius.circular(16.0))),
                                        content: (Row(children: <Widget>[
                                          Icon(
                                            Icons.warning_rounded,
                                            color: Colors.red.shade700,
                                          ),
                                          Text(
                                              "   This option only for Shift Staff")
                                        ]))));
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Qreport()),
                                );
                              }
                            },
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0xff8E8FC9).withOpacity(0.3)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(Reports),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Reports",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginPage()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0xff8E8FC9).withOpacity(0.3)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(Logout),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
          // bottomBar()
        ],
      ),
    );
  }
}
