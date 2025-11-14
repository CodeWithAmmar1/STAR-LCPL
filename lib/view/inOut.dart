// Updated By Muhammad Fahad (01-07-24 till 05-07-24)
import 'package:app/view/QrCodeScan.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class InOut extends StatefulWidget {
  @override
  State<InOut> createState() => _InOutState();
}

class _InOutState extends State<InOut> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> navigateToQrScan(String type) async {
    String cameraScanResult = '';
    try {
      PermissionStatus camera = await Permission.camera.request();
      if (camera.isGranted) {
        print('granted');
        ScanResult result = await BarcodeScanner.scan();
        cameraScanResult = result.rawContent ?? '';
      } else {
        print('not granted');
      }
      if (cameraScanResult != '') {
        print('cameraRessult: $cameraScanResult');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => QrCodeScanPage(
              type: type,
              code: cameraScanResult,
            ),
          ),
        );
      } else {
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
              Text("   Error Scanning QR Code")
            ]))));
      }
    } catch (e) {
      print('error Whilst scanning QR Code');
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
            Text("   Error Scanning QR Code")
          ]))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Center(
            child: Text(
              'IN / OUT Form',
              style: TextStyle(color: Colors.white),
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 108.0),
              child: Container(
                // padding: EdgeInsets.only(top: 50),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.red.shade900,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () => navigateToQrScan('IN'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red.shade900,
                    elevation: 0,
                    // Elevation
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold, // Bold text
                      fontSize: 34, // Larger font size
                    ),
                    // padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  ),
                  child: Text('IN'),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 108.0),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.red.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  onPressed: () => navigateToQrScan('OUT'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red.shade900,
                    elevation: 0,
                    // Elevations
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold, // Bold text
                      fontSize: 34, // Larger font size
                    ),
                    // padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  ),
                  child: Text('OUT'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}