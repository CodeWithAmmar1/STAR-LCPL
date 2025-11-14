
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import '../ui/widgets/textformfield.dart';

class QrGenerator extends StatefulWidget {
  @override
  State<QrGenerator> createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  TextEditingController _vehicleNo = TextEditingController();
  final _scaffold = GlobalKey<ScaffoldState>();
  ValueNotifier<String> _valueNotify = ValueNotifier<String>('');
  GlobalKey _qrKey = GlobalKey();
  List<String> unregisteredVehicles = [];
  List<String> unregisteredVehiclesList = [];
  List<String> unregisteredComputers = [];
  List<String> unregisteredComputersList = [];
  ScrollController _scrollController = ScrollController();

  Future<void> durationVoid() async {
    await Future.delayed((Duration(milliseconds: 600)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vehicleNo.addListener(() {
      if (_vehicleNo.text != _valueNotify.value) {
        print('listening');
        setState(() {
          _valueNotify.value = _vehicleNo.text;
        });
        print('val: ${_valueNotify.value}');
      }
    });
    try {
      getCarNoQr('http://144.126.197.51:5000/getcarqrno');
    } catch (e) {
      print('error in getcarqrno: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Center(
            child: Text(
          'QR Code Form',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.only(left: 8, top: 3),
                  height: 30,
                  width: width - 20,
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.023,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text('QR Number',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Container(
                  width: width * 0.5,
                  height: height * 0.045,
                  padding: EdgeInsets.only(
                    top: 0,
                    right: 20,
                  ),
                  child: TextField(
                    controller: _vehicleNo,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 1,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 7),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.shade900),
                      ),
                    ),
                    inputFormatters: [UpperCaseText()],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.023,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text('Select Item From List',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Container(
                    width: 125,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // padding: EdgeInsets.only(right: 20),
                    child: TextButton(
                      onPressed: () {
                        if (unregisteredVehicles.isEmpty) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => WillPopScope(
                                onWillPop: () async => false,
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  title: Container(
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade900,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        'No Item Available For QR Code',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  titlePadding: EdgeInsets.zero,
                                  contentPadding: EdgeInsets.only(top: 10),
                                  content: Container(
                                    color: Colors.white,
                                    width: double.maxFinite,
                                    height: 40,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Okay'),
                                    )
                                  ],
                                )),
                          );
                          return;
                        }
                        showDialog(
                          context: context,
                          builder: (context) {
                            // backgroundColor: Colors.red.shade900,
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                title: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 7),
                                        decoration: BoxDecoration(
                                            color: Colors.red.shade900,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                topLeft: Radius.circular(10))
                                            // border: BorderRadius()
                                            ),
                                        width: double.maxFinite,
                                        child: Center(
                                          child: Text(
                                            'Unregistered Item For QR Code',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Center(
                                          child: Text(
                                            'Search',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: width * 0.5,
                                          height: height * 0.03,
                                          padding: EdgeInsets.only(
                                            top: 0,
                                            right: 7,
                                          ),
                                          child: TextField(
                                            onChanged: (val) {
                                              print('changing');
                                              setState(() {
                                                if (val.isEmpty) {
                                                  print('empty');
                                                  unregisteredVehiclesList = [
                                                    ...unregisteredVehicles
                                                  ];
                                                } else {
                                                  print('changing: $val');
                                                  unregisteredVehiclesList =
                                                      unregisteredVehicles
                                                          .where((test) => test
                                                              .contains(val))
                                                          .toList();

                                                  print(
                                                      'unregValues: $unregisteredVehiclesList');
                                                }
                                              });
                                            },
                                            controller: _vehicleNo,
                                            keyboardType:
                                                TextInputType.multiline,
                                            minLines: 1,
                                            maxLines: 1,
                                            style: TextStyle(fontSize: 14),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(width: 3)),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red.shade900),
                                              ),
                                            ),
                                            inputFormatters: [UpperCaseText()],
                                          ),
                                        ),
                                        Icon(Icons.search_outlined),
                                      ],
                                    ),
                                  ],
                                ),
                                titlePadding: EdgeInsets.all(0),
                                contentPadding: EdgeInsets.only(top: 10),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      width: double.maxFinite,
                                      height: height * 0.4,
                                      child: Scrollbar(
                                        controller: _scrollController,
                                        thumbVisibility: true,
                                        child: ListView.builder(
                                          controller: _scrollController,
                                          shrinkWrap: true,
                                          itemCount:
                                              unregisteredVehiclesList.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              key: UniqueKey(),
                                              title: Text(
                                                  unregisteredVehiclesList[
                                                      index]),
                                              onTap: () {
                                                setState(() {
                                                  _vehicleNo.text =
                                                      unregisteredVehiclesList[
                                                          index];
                                                });
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                          },
                        );
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Select',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      // style: ElevatedButton.styleFrom(
                      //   // maximumSize: Size.square(100),
                      //   backgroundColor: Colors.grey.shade300,
                      //   elevation: 0,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.19,
            ),
         
            ValueListenableBuilder(
              valueListenable: _valueNotify,
              builder: (context, value, child) {
                print('inside');
                return FutureBuilder(
                    future: durationVoid(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        return RepaintBoundary(
                          key: _qrKey,
                          child: QrImageView(
                            data: _valueNotify.value,
                            version: QrVersions.auto,
                            size: 200,
                            gapless: false,
                          ),
                        );
                      }
                    });
              },
            ),
            SizedBox(
              height: height * 0.13,
            ),
            Container(
              width: 125,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () async {
                  if (_valueNotify.value.isEmpty) {
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
                          Text("   Please Chose Valid Vehicle/QR Code Number")
                        ]))));
                    return;
                  }
                  String url = 'http://144.126.197.51:5000/postcarnoqr';

                  try {
                    var response = await http.get(
                        Uri.parse('http://144.126.197.51:5000/getqrmax'),
                        headers: {'Content-Type': 'application/json'});
                    // print(
                    //     (jsonDecode(response.body)['results'][0] + 1).toString());
                    String count = '';
                    if (jsonDecode(response.body)['results'][0] == null) {
                      count = '1';
                    } else {
                      count = (jsonDecode(response.body)['results'][0] + 1)
                          .toString();
                    }

                    SharedPreferences sharedPreference =
                        await SharedPreferences.getInstance();
                    String uName = sharedPreference.getString('userid') ?? '';
                    String formattedDate = DateFormat('dd-MMM-yy')
                        .format(DateTime.now())
                        .toUpperCase();
                    Map<String, dynamic> body = {
                      'trans_id': count,
                      'qrcode': _valueNotify.value,
                      'create_by': uName,
                      'create_date': formattedDate,
                    };
                    await postQRData(url, body);
                  } catch (e) {
                    print(e);

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
                          Text("   An Error Occurred Upon Generating QR Code")
                        ]))));
                  }
                },
                child: Text(
                  'Generate',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: Colors.grey.shade300,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getUnRegComp(String url) async {
    var response = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
    print('response.body: ${response.body}');
    if (response.statusCode == 200) {
      print('done');
      final data = jsonDecode(response.body);

      // print('data: ${data['results']}');
      data['results'].forEach((code) {
        unregisteredComputers.add(code[0].toString());

        // print('Code: $code');
        // unregisteredVehicles.add(code);
      });
      //good
    } else {
      print('error');
    }
  }

  Future<void> getCarNoQr(String url) async {
    var response = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
    print('response.body: ${response.body}');
    if (response.statusCode == 200) {
      print('done');
      final data = jsonDecode(response.body);

      // print('data: ${data['results']}');
      data['results'].forEach((code) {
        unregisteredVehicles.add(code[0].toString());
        unregisteredVehiclesList.add(code[0].toString());

        // print('Code: $code');
        // unregisteredVehicles.add(code);
      });
      // unregisteredVehiclesList.addAll();
      // = unregisteredVehicles;
      //good
    } else {
      print('error');
    }
  }

  Future postQRData(String url, Map<String, dynamic> body) async {
    var response = await http.post(Uri.parse(url), body: body);
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('response.body: $data');
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.red.shade900,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                height: 50,
                child: Center(
                  child: Text(
                    'QR Code Successfully Generated',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
              ),
              titlePadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.only(top: 10),
              content: Container(
                color: Colors.white,
                width: double.maxFinite,
                height: 40,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay'),
                )
              ],
            )),
      );
    } else if (response.statusCode == 500 || response.statusCode == 404) {
      print('error');
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
            Text("   An Error Occurred Upon Generating QR Code")
          ]))));
    } else {
      throw 'Error';
    }
  }

  searchQR(String arg, List<String> data, List<String> list) {
    print('args: $arg');
    if (arg.isEmpty) {
      // list = data;
      data.forEach((val) {
        list.add(val);
      });
      setState(() {});
      print('list: $list');
      return;
    }
    list = [];
    data.forEach((val) {
      if (val.contains(arg)) {
        list.add(val);
      }
    });
    setState(() {});
    print('list: $list');
  }
}
