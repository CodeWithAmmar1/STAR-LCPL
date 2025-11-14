
import 'package:app/constants/constants.dart';
import 'package:app/screens/carfeedback.dart';
import 'package:app/tabs/Qtab.dart';
import 'package:app/ui/splashscreen.dart';
import 'package:app/view/HomePage.dart';
import 'package:app/view/QrCodeScan.dart';
import 'package:app/view/QrGenerator.dart';
import 'package:app/view/inOut.dart';
import 'package:app/view/loginPage.dart';
import 'package:app/view/selectarea.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


SharedPreferences? sharedPrefs;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  //Done By ALI AMMAR 13-11-2025
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // TODO: implement didChangeAppLifecycleState
  //
  //   super.didChangeAppLifecycleState(state);
  //   // print('-----------------start--------');
  //   // print('state: Name ${state.name}');
  //   // print('-----------------end--------');
  //   //
  //   // if (state == AppLifecycleState.paused) {
  //   //   navKey.currentState?.pushAndRemoveUntil(
  //   //     MaterialPageRoute(builder: (context) => LoginPage()),
  //   //     (Route<dynamic> routes) => false,
  //   //   );
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Lotte',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
        Sign_In: (BuildContext context) => LoginPage(),
        Home_Page: (context) => HomePage(),
        Select_Area: (BuildContext context) => SelectArea(),
        Q_tab: (BuildContext context) => Qtab(),
        Car_Feedback: (BuildContext context) => CarFeedback(),
        Qr_Generator: (context) => QrGenerator(),
        Qr_Scan: (context) => QrCodeScanPage(),
        In_Out: (context) => InOut(),
      },
      initialRoute: SPLASH_SCREEN,
      // initialRoute: Qr_Scan,
      home: HomePage(),
      // initialRoute: Qr_Generator,
      // initialRoute: '/',
    ); 
  }
}
