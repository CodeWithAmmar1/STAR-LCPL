import 'package:LotteRota/tabs/QtabPageView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPrefs;

class Qtab extends StatefulWidget {
  @override
  _Qtab createState() => _Qtab();
}

class _Qtab extends State<Qtab> with SingleTickerProviderStateMixin {
  late TabController tabController;
  String? fdate;
  String? tdate;
  String? fshift;
  String? farea;
  List<String> selected = [];
  var selectedDate = '';
  int currentindex2 = 0;

  int selectedIndex = 0;

  // SwiperController _scrollController = new SwiperController();

  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      fdate = sharedPrefs?.getString('fdate');
      tdate = sharedPrefs?.getString('tdate');
      fshift = sharedPrefs?.getString('fshift');
      farea = sharedPrefs?.getString('farea');
      selected = sharedPrefs?.getStringList('selected') as List<String>;
      tabView();

      tabController = TabController(
        initialIndex: selectedIndex,
        length: selected.length,
        vsync: this,
      );

      tabController.addListener(() {
        setState(() {
          print(tabController.index);
          // _scrollController.move(tabController.index);
          selectedIndex = tabController.index;
          tabView();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: selected.length,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red.shade900,
              title: Text(
                'From: ' + (fdate ?? '') + ' To: ' + (tdate ?? ''),
                style: TextStyle(fontSize: 16),
              ),
              centerTitle: true,
              bottom: TabBar(
                controller: tabController,
                isScrollable: true,
                indicatorWeight: 2.0,
                indicatorColor: Colors.red.shade900,
                tabs: List<Widget>.generate(selected.length, (int index) {
                  return new Tab(text: selected[index]);
                }),
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: List<Widget>.generate(selected.length, (int index) {
                return new QTabPageView();
              }),
            )),
      ),
    );
  }

  Future<void> tabView() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    if (selected.length != 0) {
      selectedDate = selected[tabController.index];
      sharedPreference.setString("selectedDate", selectedDate);
      print(selectedDate);
    }
  }
}
