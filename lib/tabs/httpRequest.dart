import 'dart:convert';
import 'package:LotteRota/tabs/tabHeader.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPrefs1;

class HttpRequest extends ChangeNotifier {
  var routedate = '';
  var routearea = '';

  SharedPreferences? sharedPreferences1;

  TabHeader? data;

  Future getHttpData(context) async {
    SharedPreferences.getInstance().then((prefs) {
      sharedPrefs1 = prefs;
      routedate = sharedPrefs1?.getString('routedate') ?? '';
      routearea = sharedPrefs1?.getString('routearea') ?? '';
    });
    if ((routearea != "") || (routedate != "")) {
      var url =
          'http://144.126.197.51:5000/tifrout/' + routedate + '/' + routearea;
      final response = await http
          .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
      // now we have response as String from local json or and API request...
      var mJson = json.decode(response.body);
      // now we have a json...
      this.data = TabHeader.fromJson(mJson);
      // print('Data = $this.data');
      this.notifyListeners(); // for callback to view
    }
  }
}
