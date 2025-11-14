import 'dart:convert';
import 'package:LotteRota/constants/constants.dart';
import 'package:LotteRota/dialog/customdialog.dart';
import 'package:LotteRota/ui/widgets/custom_shape.dart';
import 'package:LotteRota/ui/widgets/passformfield.dart';
import 'package:LotteRota/ui/widgets/responsive_ui.dart';
import 'package:LotteRota/ui/widgets/textformfield.dart';
import 'package:LotteRota/view/HomePage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _height = 0;
  double _width = 0;
  double _pixelRatio = 0;
  bool _large = false;
  bool _medium = false;

  final TextEditingController useridController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String SERIALNO = '';

  @override
  Widget build(BuildContext context) {
    getserial();
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
      body: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              Text("  Configured by Ali Ammar \naliammar0342@gmail.com",style: TextStyle(fontWeight: FontWeight.bold ),),
              welcomeTextRow(),
              signInTextRow(),
              form(),
              SizedBox(height: _height / 12),
              button(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getserial() async {
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    setState(() {
      SERIALNO = androidInfo.board;
    });
  }

  Future<void> signIn(String userid, pass) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    // String url = 'http://10.0.1.49:5000/login/' +
        String url = 'http://144.126.197.51:5000/login/' +
        userid.trim() +
        '/' +
        pass.trim() +
        '/' +
        SERIALNO.trim();
    final Uri uri = Uri.parse(url);
    Map data = {'userid': userid, 'password': pass, 'serialno': SERIALNO};
    print('url: $url');
    var response =
        await http.get(uri, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {});
        data = jsonResponse['driver'][0];
        print(data['USER_ID']);
        print(data['STAFF_NO']);
        print(data['USER_NAME']);
        print(data['CELL_NO']);
        print(data['SERIAL_NO']);
        sharedPreference.setString("userid", data['USER_ID']);
        sharedPreference.setString("staffno", data['STAFF_NO']);
        sharedPreference.setString("username", data['USER_NAME']);
        sharedPreference.setString("cellno", data['CELL_NO']);
        var url1 = 'http://144.126.197.51:5000/verify/' + data['STAFF_NO'];
        var resp = await http.get(Uri.parse(url1),
            headers: {"Content-Type": "application/json"});
        if (resp.statusCode == 200) {
          var jsonResponse = json.decode(resp.body);
          data = jsonResponse['verify'][0];
          print(data['AREA']);
          print(data['AREA_CATEGORY']);
          sharedPreference.setString("area", data['AREA']);
          sharedPreference.setString("areacat", data['AREA_CATEGORY']);
          sharedPreference.setString("resp", '200');
        } else {
          sharedPreference.setString("resp", 'null');
        }

        final action = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => CustomDialog(
                  title: "Login Successful",
                  description: "Welcome to LOTTE Chemical Pak.",
                  img: 'assets/images/ok.gif',
                ));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
        );
      }
    } else {
      var jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      jsonResponse = json.decode(response.body);
      useridController.text = "";
      passwordController.text = "";
      if (jsonResponse != null) {
        final action = await showDialog(
            context: context,
            builder: (context) => CustomDialog(
                  title: "Login Failed",
                  description: "Login failed, " + jsonResponse['message'],
                  img: 'assets/images/no.gif',
                ));
      } else {
        final action = await showDialog(
            context: context,
            builder: (context) => CustomDialog(
                  title: "Login Failed",
                  description:
                      "Login failed, Please check you internet connection or Contact your system Admin.",
                  img: 'assets/images/no.gif',
                ));
      }
      setState(() {});
      print(response.body);
    }
  }

  Widget button() {
    return GestureDetector(
      onTap: useridController.text == "" || passwordController.text == ""
          ? null
          : () async {
              setState(() {});
              await signIn(useridController.text, passwordController.text);
            },
      child: Container(
        alignment: Alignment.center,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('SignIn',
            style: TextStyle(
                fontSize: _large ? 14 : (_medium ? 12 : 10),
                color: Colors.white)),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 4
                  : (_medium ? _height / 3.75 : _height / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
              top: _large
                  ? _height / 30
                  : (_medium ? _height / 25 : _height / 20)),
          child: Image.asset(
            'assets/images/login.png',
            height: _height / 3.5,
            width: _width / 3.5,
          ),
        ),
      ],
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          Text(
            "Welcome",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _large ? 60 : (_medium ? 50 : 40),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Sign in to your account",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: _large ? 20 : (_medium ? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            useridTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget useridTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.name,
      textEditingController: useridController,
      icon: Icons.person,
      hint: "User ID",
    );
  }

  Widget passwordTextFormField() {
    return PasswordTextField(
      keyboardType: TextInputType.name,
      textEditingController: passwordController,
      icon: Icons.lock,
      obscureText: true,
      hint: "Password",
    );
  }

  Widget forgetPassTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Forgot your password?",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              print("Routing");
            },
            child: Text(
              "Recover",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.orange[200]),
            ),
          )
        ],
      ),
    );
  }

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(SIGN_UP);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.orange[200],
                  fontSize: _large ? 19 : (_medium ? 17 : 15)),
            ),
          )
        ],
      ),
    );
  }
}
