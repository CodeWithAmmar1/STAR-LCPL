import 'package:LotteRota/tabs/QhttpRequest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPrefs;

class QTabPageView extends StatefulWidget {
  QTabPageView() : super();

  @override
  QTabPageViewState createState() => QTabPageViewState();
}

class QTabPageViewState extends State<QTabPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<QHttpRequest>(
        create: (context) => QHttpRequest(),
        child: Consumer<QHttpRequest>(
          builder: (context, provider, child) {
            if (provider.data == null) {
              provider.getHttpData(context);
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
                            width: 200,
                            child: Text(
                              'Employee Name',
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
                                      data.gp,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    )),
                              ),
                              DataCell(Container(
                                  width: 200,
                                  child: Text(
                                    data.name.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ))),
                              DataCell(Container(
                                  width: 20,
                                  child: Text(
                                    data.shift,
                                    style: TextStyle(fontSize: 12),
                                  ))),
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
