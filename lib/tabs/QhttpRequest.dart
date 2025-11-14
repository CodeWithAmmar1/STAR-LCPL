import 'dart:convert';
import 'package:app/tabs/QtabHeader.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPrefs2;

class QHttpRequest extends ChangeNotifier {
  var selectedDate = '';
  var farea = '';
  var fshift = '';
  var url = '';
  SharedPreferences? sharedPreferences;

  QTabHeader? data;
  Future getHttpData(context) async {
    SharedPreferences.getInstance().then((prefs) {
      sharedPrefs2 = prefs;
      selectedDate = sharedPrefs2?.getString('selectedDate') ?? '';
      farea = sharedPrefs2?.getString('farea') ?? '';
      fshift = sharedPrefs2?.getString('fshift') ?? '';
      getData();
    });
  }

  Future getData() async {
    if ((selectedDate != "") ||
        (farea != "")) {
      if (farea != 'ALL' && fshift == 'ALL') {
        url =
            'http://144.126.197.51:5000/Report1/' + selectedDate + '/' + farea;
      }

      if (farea == 'ALL' && fshift == 'ALL') {
        url = 'http://144.126.197.51:5000/Report/' + selectedDate;
      }

      if (farea != 'ALL' && fshift != 'ALL') {
        url = 'http://144.126.197.51:5000/Report2/' +
            selectedDate +
            '/' +
            farea +
            '/' +
            fshift;
      }

      if (farea == 'ALL' && fshift != 'ALL') {
        url =
            'http://144.126.197.51:5000/Report3/' + selectedDate + '/' + fshift;
      }

      final response = await http
          .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
      // now we have response as String from local json or and API request...
      var mJson = json.decode(response.body);
      // now we have a json...
      this.data = QTabHeader.fromJson(mJson);
      print('Data = $mJson');
      this.notifyListeners(); // for callback to view
    }
  }
}
