
import 'package:LotteRota/view/AreaReport.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart' as sg;

late SharedPreferences sharedPrefs;

class SelectArea extends StatefulWidget {
  @override
  _SelectArea createState() => _SelectArea();
}

class _SelectArea extends State<SelectArea> {
  Material menuItems(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    heading,
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  late SharedPreferences sharedPreferences;
  var userid = '';
  var unam = '';
  var cellno = '';
  var area = '';
  var areacat = '';

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
      // propic = sharedPrefs.getString('userprofilepic');
    });
    // checkLoginStatus();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red.shade700,
          title: Text(
            'Select Area',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Builder(builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: sg.StaggeredGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              children: <Widget>[
                sg.StaggeredGridTile.extent(
                  crossAxisCellCount: 1,
                  mainAxisExtent: 100.0,
                  child: InkWell(
                    onTap: () {
                      if (area == "COGEN" || area == "OX") {
                        sharedPrefs.setString("area", 'COGEN');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AreaReport()),
                        );
                      } else {
                        SnackBar mySnackBar = SnackBar(
                            behavior: SnackBarBehavior.fixed,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0))),
                            content: (Row(children: <Widget>[
                              Icon(
                                Icons.warning_rounded,
                                color: Colors.red.shade700,
                              ),
                              Text(" You are only Authorize to use $area Area")
                            ])));
                        ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
                      }
                    },
                    child: menuItems(Icons.graphic_eq, "COGEN", 0xffed622b),
                  ),
                ),
                sg.StaggeredGridTile.extent(
                  crossAxisCellCount: 1,
                  mainAxisExtent: 100.0,
                  child: InkWell(
                    onTap: () {
                      if (area == "ELECTRICAL" || area == "OX") {
                        sharedPrefs.setString("area", 'ELECTRICAL');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AreaReport()),
                        );
                      } else {
                        SnackBar mySnackBar = SnackBar(
                            behavior: SnackBarBehavior.fixed,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0))),
                            content: (Row(children: <Widget>[
                              Icon(
                                Icons.warning_rounded,
                                color: Colors.red.shade700,
                              ),
                              Text(" You are only Authorize to use $area Area")
                            ])));
                        ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
                      }
                    },
                    child: menuItems(Icons.graphic_eq, "ELECTRICAL", 0xffed622b),
                  ),
                ),
                sg.StaggeredGridTile.extent(
                  crossAxisCellCount: 1,
                  mainAxisExtent: 100.0,
                  child: InkWell(
                    onTap: () {
                      if (area == "UTILITY" || area == "OX") {
                        sharedPrefs.setString("area", 'UTILITY');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AreaReport()),
                        );
                      } else {
                        SnackBar mySnackBar = SnackBar(
                            behavior: SnackBarBehavior.fixed,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0))),
                            content: (Row(children: <Widget>[
                              Icon(
                                Icons.warning_rounded,
                                color: Colors.red.shade700,
                              ),
                              Text(" You are only Authorize to use $area Area")
                            ])));
                        ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
                      }
                    },
                    child: menuItems(Icons.graphic_eq, "UTILITY", 0xffed622b),
                  ),
                ),
                sg.StaggeredGridTile.extent(
                  crossAxisCellCount: 1,
                  mainAxisExtent: 100.0,
                  child: InkWell(
                    onTap: () {
                      if (area == "INSTRUMENT" || area == "OX") {
                        sharedPrefs.setString("area", 'INSTRUMENT');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AreaReport()),
                        );
                      } else {
                        SnackBar mySnackBar = SnackBar(
                            behavior: SnackBarBehavior.fixed,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0))),
                            content: (Row(children: <Widget>[
                              Icon(
                                Icons.warning_rounded,
                                color: Colors.red.shade700,
                              ),
                              Text(" You are only Authorize to use $area Area")
                            ])));
                        ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
                      }
                    },
                    child: menuItems(Icons.graphic_eq, "INSTRUMENT", 0xffed622b),
                  ),
                ),
                sg.StaggeredGridTile.extent(
                  crossAxisCellCount: 1,
                  mainAxisExtent: 100.0,
                  child: InkWell(
                    onTap: () {
                      if (area == "LAB" || area == "OX") {
                        sharedPrefs.setString("area", 'LAB');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AreaReport()),
                        );
                      } else {
                        SnackBar mySnackBar = SnackBar(
                            behavior: SnackBarBehavior.fixed,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0))),
                            content: (Row(children: <Widget>[
                              Icon(
                                Icons.warning_rounded,
                                color: Colors.red.shade700,
                              ),
                              Text(" You are only Authorize to use $area Area")
                            ])));
                        ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
                      }
                    },
                    child: menuItems(Icons.graphic_eq, "LAB", 0xffed622b),
                  ),
                ),
                sg.StaggeredGridTile.extent(
                  crossAxisCellCount: 1,
                  mainAxisExtent: 100.0,
                  child: InkWell(
                    onTap: () {
                      if (area == "MECHANICAL" || area == "OX") {
                        sharedPrefs.setString("area", 'MECHANICAL');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AreaReport()),
                        );
                      } else {
                        SnackBar mySnackBar = SnackBar(
                            behavior: SnackBarBehavior.fixed,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0))),
                            content: (Row(children: <Widget>[
                              Icon(
                                Icons.warning_rounded,
                                color: Colors.red.shade700,
                              ),
                              Text(" You are only Authorize to use $area Area")
                            ])));
                        ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
                      }
                    },
                    child: menuItems(Icons.graphic_eq, "MECHANICAL", 0xffed622b),
                  ),
                ),
                sg.StaggeredGridTile.extent(
                  crossAxisCellCount: 1,
                  mainAxisExtent: 100.0,
                  child: InkWell(
                    onTap: () {
                      if (area == "OX") {
                        sharedPrefs.setString("area", 'OX');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AreaReport()),
                        );
                      } else {
                        SnackBar mySnackBar = SnackBar(
                            behavior: SnackBarBehavior.fixed,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0))),
                            content: (Row(children: <Widget>[
                              Icon(
                                Icons.warning_rounded,
                                color: Colors.red.shade700,
                              ),
                              Text(" You are only Authorize to use $area Area")
                            ])));
                        ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
                      }
                    },
                    child: menuItems(Icons.graphic_eq, "OX", 0xffed622b),
                  ),
                ),
                sg.StaggeredGridTile.extent(
                  crossAxisCellCount: 1,
                  mainAxisExtent: 100.0,
                  child: InkWell(
                    onTap: () {
                      if (area == "PURE" || area == "OX") {
                        sharedPrefs.setString("area", 'PURE');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AreaReport()),
                        );
                      } else {
                        SnackBar mySnackBar = SnackBar(
                            behavior: SnackBarBehavior.fixed,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0))),
                            content: (Row(children: <Widget>[
                              Icon(
                                Icons.warning_rounded,
                                color: Colors.red.shade700,
                              ),
                              Text(" You are only Authorize to use $area Area")
                            ])));
                        ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
                      }
                    },
                    child: menuItems(Icons.graphic_eq, "PURE", 0xffed622b),
                  ),
                ),
                sg.StaggeredGridTile.extent(
                  crossAxisCellCount: 2,
                  mainAxisExtent: 100.0,
                  child: InkWell(
                    onTap: () {
                      if (area == "HR & ADMINISTRATION" || area == "OX") {
                        sharedPrefs.setString("area", 'HR & ADMINISTRATION');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AreaReport()),
                        );
                      } else {
                        SnackBar mySnackBar = SnackBar(
                            behavior: SnackBarBehavior.fixed,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0))),
                            content: (Row(children: <Widget>[
                              Icon(
                                Icons.warning_rounded,
                                color: Colors.red.shade700,
                              ),
                              Text(" You are only Authorize to use $area Area")
                            ])));
                        ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
                      }
                    },
                    child: menuItems(
                        Icons.graphic_eq, "HR & ADMINISTRATION", 0xffed622b),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}