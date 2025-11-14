import 'package:app/tabs/tabPage.dart';
import 'package:app/tabs/tabPageView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_format/date_format.dart';

SharedPreferences? sharedPrefs;

class AreaReport extends StatefulWidget {
  @override
  _AreaReport createState() => _AreaReport();
}

class _AreaReport extends State<AreaReport>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  SharedPreferences? sharedPreferences;
  var userid = '';
  var unam = '';
  var cellno = '';
  var area = '';
  var areacat = '';
  var routedate = '';
  var routearea = '';

  var todaydate;
  var yesdate;
  var yesbefdate;
  var date1;
  var date2;
  var date3;
  var date4;
  var date5;
  var date6;
  var date7;
  var date8;
  var date9;
  var date10;
  var date11;
  var date12;
  var date13;
  var date14;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 17, vsync: this);

    _tabController.addListener(() {
      if (mounted) {
        setState(() {
          _selectedIndex = _tabController.index;
          getData();
        });
      } else {
        return;
      }
      // getData();
      print("Selected Index: " + _selectedIndex.toString());
    });

    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      userid = sharedPrefs?.getString('userid') ?? '';
      unam = sharedPrefs?.getString('username') ?? '';
      cellno = sharedPrefs?.getString('cellno') ?? '';
      area = sharedPrefs?.getString('area') ?? '';
      areacat = sharedPrefs?.getString('areacat') ?? '';
    });
    todaydate = DateTime.now();
    yesdate = todaydate.add(new Duration(days: -1));
    yesbefdate = todaydate.add(new Duration(days: -2));
    date1 = todaydate.add(new Duration(days: 1));
    date2 = todaydate.add(new Duration(days: 2));
    date3 = todaydate.add(new Duration(days: 3));
    date4 = todaydate.add(new Duration(days: 4));
    date5 = todaydate.add(new Duration(days: 5));
    date6 = todaydate.add(new Duration(days: 6));
    date7 = todaydate.add(new Duration(days: 7));
    date8 = todaydate.add(new Duration(days: 8));
    date9 = todaydate.add(new Duration(days: 9));
    date10 = todaydate.add(new Duration(days: 10));
    date11 = todaydate.add(new Duration(days: 11));
    date12 = todaydate.add(new Duration(days: 12));
    date13 = todaydate.add(new Duration(days: 13));
    date14 = todaydate.add(new Duration(days: 14));

    todaydate = formatDate(todaydate, [dd, '-', M, '-', yyyy]);
    yesdate = formatDate(yesdate, [dd, '-', M, '-', yyyy]);
    yesbefdate = formatDate(yesbefdate, [dd, '-', M, '-', yyyy]);
    date1 = formatDate(date1, [dd, '-', M, '-', yyyy]);
    date2 = formatDate(date2, [dd, '-', M, '-', yyyy]);
    date3 = formatDate(date3, [dd, '-', M, '-', yyyy]);
    date4 = formatDate(date4, [dd, '-', M, '-', yyyy]);
    date5 = formatDate(date5, [dd, '-', M, '-', yyyy]);
    date6 = formatDate(date6, [dd, '-', M, '-', yyyy]);
    date7 = formatDate(date7, [dd, '-', M, '-', yyyy]);
    date8 = formatDate(date8, [dd, '-', M, '-', yyyy]);
    date9 = formatDate(date9, [dd, '-', M, '-', yyyy]);
    date10 = formatDate(date10, [dd, '-', M, '-', yyyy]);
    date11 = formatDate(date11, [dd, '-', M, '-', yyyy]);
    date12 = formatDate(date12, [dd, '-', M, '-', yyyy]);
    date13 = formatDate(date13, [dd, '-', M, '-', yyyy]);
    date14 = formatDate(date14, [dd, '-', M, '-', yyyy]);
    getData();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 17,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade900,
          title: Text(
            area,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
              // fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal,
            ),
          ),
          centerTitle: true,
          bottom: getTabBar(),
        ),
        body: getTabBarView(),
      ),
    );
  }

  getTabBar() {
    return TabBar(
      isScrollable: true,
      controller: _tabController,
      indicatorWeight: 1.0,
      indicatorColor: Colors.red.shade900,
      tabs: <Widget>[
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                yesbefdate.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                yesdate.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                todaydate.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                date1.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                date2.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                date3.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                date4.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                date5.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                date6.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                date7.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                date8.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                date9.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                date10.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                date11.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                date12.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                date13.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                date14.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> getData() async {
    SharedPreferences sharedPreference1 = await SharedPreferences.getInstance();
    if (_selectedIndex == 0) {
      sharedPreference1.setString(
          "routedate", yesbefdate.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }

    if (_selectedIndex == 1) {
      sharedPreference1.setString(
          "routedate", yesdate.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }

    if (_selectedIndex == 2) {
      sharedPreference1.setString(
          "routedate", todaydate.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }

    if (_selectedIndex == 3) {
      sharedPreference1.setString("routedate", date1.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }
    if (_selectedIndex == 4) {
      sharedPreference1.setString("routedate", date2.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }
    if (_selectedIndex == 5) {
      sharedPreference1.setString("routedate", date3.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }
    if (_selectedIndex == 6) {
      sharedPreference1.setString("routedate", date4.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }
    if (_selectedIndex == 7) {
      sharedPreference1.setString("routedate", date5.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }
    if (_selectedIndex == 8) {
      sharedPreference1.setString("routedate", date6.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }
    if (_selectedIndex == 9) {
      sharedPreference1.setString("routedate", date7.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }
    if (_selectedIndex == 10) {
      sharedPreference1.setString("routedate", date8.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }
    if (_selectedIndex == 11) {
      sharedPreference1.setString("routedate", date9.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }
    if (_selectedIndex == 12) {
      sharedPreference1.setString("routedate", date10.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }
    if (_selectedIndex == 13) {
      sharedPreference1.setString("routedate", date11.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }
    if (_selectedIndex == 14) {
      sharedPreference1.setString("routedate", date12.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }
    if (_selectedIndex == 15) {
      sharedPreference1.setString("routedate", date13.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }
    if (_selectedIndex == 16) {
      sharedPreference1.setString("routedate", date14.toString().toUpperCase());
      sharedPreference1.setString("routearea", area);
    }
  }

  getTabBarView() {
    if (areacat == "SR. SHIFT MANAGER" ||
        areacat == "SHIFT MANAGER" ||
        areacat == "ADMIN OFFICER" ||
        areacat == "ENGINEER MECH" ||
        areacat == "ENGINEER ELEC" ||
        areacat == "ENGINEER INST" ||
        areacat == "LAB") {
      return TabBarView(
        controller: _tabController,
        children: <Widget>[
          TabPage(),
          TabPage(),
          TabPage(),
          TabPage(),
          TabPage(),
          TabPage(),
          TabPage(),
          TabPage(),
          TabPage(),
          TabPage(),
          TabPage(),
          TabPage(),
          TabPage(),
          TabPage(),
          TabPage(),
          TabPage(),
          TabPage(),
        ],
      );
    } else {
      return TabBarView(
        controller: _tabController,
        children: <Widget>[
          TabPageView(),
          TabPageView(),
          TabPageView(),
          TabPageView(),
          TabPageView(),
          TabPageView(),
          TabPageView(),
          TabPageView(),
          TabPageView(),
          TabPageView(),
          TabPageView(),
          TabPageView(),
          TabPageView(),
          TabPageView(),
          TabPageView(),
          TabPageView(),
          TabPageView(),
        ],
      );
    }
  }
}
