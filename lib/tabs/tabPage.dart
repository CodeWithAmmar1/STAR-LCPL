import 'package:app/tabs/httpRequest.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPrefs;

class TabPage extends StatefulWidget {
  TabPage() : super();

  final String title = "Data Table Flutter Demo";

  @override
  TabPageState createState() => TabPageState();
}

class TabPageState extends State<TabPage> {
  SharedPreferences? sharedPreferences;

  var userid = '';
  var unam = '';
  var cellno = '';
  var area = '';
  var areacat = '';
  var ushiftid = '';
  var ushiftname = '';
  var uempid = '';
  var ushiftdate = '';
  var remarks = '';
  var todaydate;

  String? selecteName;
  List data1 = [];
  var data2;
  var data3;
  var data4;
  var data5;
  var shiftid;
  var cellno1;
  String? oldshift;
  String? oldshiftid;

  Future getAllShifts() async {
    var response = await http.get(
        Uri.parse("http://144.126.197.51:5000/shift/Y"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data1 = jsonData;
    });
    print(jsonData);
    return "success";
  }

  Future getShiftid(String name) async {
    var response = await http.get(
        Uri.parse("http://144.126.197.51:5000/shiftid/Y/$name"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data2 = jsonData;
      ushiftid = data2[0]['SHIFT_ID'];
    });
    print(jsonData);
    getRout();
    updateShift();

    return "success";
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      userid = sharedPrefs?.getString('userid') ?? '';
      unam = sharedPrefs?.getString('username') ?? '';
      cellno = sharedPrefs?.getString('cellno') ?? '';
      area = sharedPrefs?.getString('area') ?? '';
      areacat = sharedPrefs?.getString('areacat') ?? '';
    });
    getAllShifts();
  }

  Future updateShift() async {
    print(ushiftid);
    print(ushiftname);
    print(uempid);
    print(ushiftdate);

    var response = await http.put(
        Uri.parse(
            "http://144.126.197.51:5000/utifroute/$ushiftid/$ushiftname/$uempid/$ushiftdate"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(jsonData);
    return "success";
  }

  Future getRout() async {
    var response = await http.get(
        Uri.parse("http://144.126.197.51:5000/tifroute/$uempid/$ushiftdate"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    data4 = jsonData['results'][0];
    remarks = data4['REMARKS'];
    cellno1 = data4['CELL_NO'];
    print(data4);
    getHist();
    return "success";
  }

  Future getHist() async {
    print(ushiftid);
    print(ushiftname);
    print(uempid);
    print(ushiftdate);

    var response = await http.get(
        Uri.parse("http://144.126.197.51:5000/gethist"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    print(jsonData);
    data3 = jsonData['results'][0];
    if (data3 == null) {
      data3 = 1;
    } else {
      data3 = data3 + 1;
    }
    print(data3);
    addHist();
    return "success";
  }

  Future getSms() async {
    print(ushiftid);
    print(ushiftname);
    print(uempid);
    print(ushiftdate);

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
    addSms();
    return "success";
  }

  Future addHist() async {
    print(ushiftid);
    print(ushiftname);
    print(uempid);
    print(ushiftdate);
    todaydate = DateTime.now();
    todaydate = formatDate(todaydate, [dd, '-', M, '-', yyyy]);
    todaydate = todaydate.toString().toUpperCase();
    var TRANSID = data3;
    var POSTED = 1;
    var MOBILEADD = 1;
    String EMPNO = uempid;
    String REMARKS = remarks;
    String SHIFTID = oldshiftid ?? '';
    String UPDATEBY = userid;
    String UPDATEDATE = todaydate;
    String SHIFTDATE = ushiftdate;
    String POSTSHIFTID = ushiftid;
    String POSTUPDATEBY = userid;
    String POSTUPDATEDATE = todaydate;
    String POSTSHIFTDATE = ushiftdate;

    Map datad = {
      'TRANSID': TRANSID,
      'EMPNO': EMPNO,
      'REMARKS': REMARKS,
      'SHIFTID': SHIFTID,
      'UPDATEBY': UPDATEBY,
      'UPDATEDATE': UPDATEDATE,
      'SHIFTDATE': SHIFTDATE,
      'POSTSHIFTID': POSTSHIFTID,
      'POSTUPDATEBY': POSTUPDATEBY,
      'POSTUPDATEDATE': POSTUPDATEDATE,
      'POSTSHIFTDATE': POSTSHIFTDATE,
      'POSTED': POSTED,
      'MOBILEADD': MOBILEADD
      // 'password': pass,
      // 'roles': roles,
    };

    var body = json.encode(datad);
    // var response = await http.post(url,
    //     headers: {"Content-Type": "application/json"}, body: body);

    var response = await http.post(
        Uri.parse("http://144.126.197.51:5000/addhist"),
        headers: {"Content-Type": "application/json"},
        body: body);
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    getSms();
    return json.decode(response.body);
  }

  Future addSms() async {
    print(ushiftid);
    print(ushiftname);
    print(uempid);
    print(ushiftdate);
    todaydate = DateTime.now();
    todaydate = formatDate(todaydate, [dd, '-', M, '-', yyyy]);
    todaydate = todaydate.toString().toUpperCase();
    var COMPNO = data5;
    String CELLNO = cellno1;
    String MSG =
        "FYI. Your Shift of " + ushiftdate + " is " + ushiftname + ". Thanks ";
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
    // var response = await http.post(url,
    //     headers: {"Content-Type": "application/json"}, body: body);

    var response = await http.post(
        Uri.parse("http://144.126.197.51:5000/addsms"),
        headers: {"Content-Type": "application/json"},
        body: body);
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<HttpRequest>(
        create: (context) => HttpRequest(),
        child: Consumer<HttpRequest>(
          builder: (context, provider, child) {
            if (provider.data == null) {
              provider.getHttpData(context).then((_) {
                setState(() {});
              });
              return Center(child: CircularProgressIndicator());
            } else
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: DataTable(
                    dataRowHeight: 40,
                    headingRowHeight: 60,
                    columns: [
                      DataColumn(
                        label: Container(
                          color: Colors.white,
                          child: SizedBox(
                            width: 20,
                            child: Text(
                              'GP',
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          color: Colors.white,
                          child: SizedBox(
                            width: 40,
                            child: Text(
                              'Name',
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          color: Colors.white,
                          child: SizedBox(
                            width: 80,
                            child: Text(
                              'Category',
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          color: Colors.white,
                          child: SizedBox(
                            width: 30,
                            child: Text(
                              'Shift',
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: provider.data!.results
                        .map((data) => DataRow(cells: [
                              DataCell(
                                Container(
                                    width: 20,
                                    child: Text(
                                      data.gp ?? '',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    )),
                              ),
                              DataCell(Container(
                                  width: 120,
                                  child: Text(
                                    data.name?.toUpperCase() ?? '',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ))),
                              DataCell(Container(
                                  width: 120,
                                  child: Text(
                                    data.category ?? '',
                                    style: TextStyle(fontSize: 12),
                                  ))),
                              // DataCell(Container(
                              //     width: 20,
                              //     child: Text(
                              //       data.shift,
                              //       style: TextStyle(fontSize: 12),
                              //     ))),
                              // ]))
                              DataCell(
                                DropdownButton(
                                  iconSize: 0,
                                  value: selecteName,
                                  hint: Text(
                                    data.shift ?? '',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
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
                                  onTap: () {
                                    oldshift = data.shift;
                                    oldshiftid = data.shiftid;
                                  },
                                  onChanged: (value) {
                                    getShiftid(value.toString());
                                    setState(() {
                                      data.shift = value.toString();
                                      ushiftname = value.toString();
                                      uempid = data.empno ?? '';
                                      ushiftdate = provider.routedate;
                                    });
                                  },
                                ),
                              ),
                            ]))
                        .toList(),
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}
