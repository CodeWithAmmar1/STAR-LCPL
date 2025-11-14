// Updated By Muhammad Fahad (01-07-24 till 05-07-24)

import 'dart:convert';
import 'dart:io' as io;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart';
import '../ui/widgets/textformfield.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

import 'HomePage.dart';

class QrCodeScanPage extends StatefulWidget {
  String type = '';
  String code = '';

  @override
  State<QrCodeScanPage> createState() => _QrCodeScanPageState();

  QrCodeScanPage({this.type = '', this.code = ''});
}

class _QrCodeScanPageState extends State<QrCodeScanPage> {
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  var result;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String type = '';
  String code = '';
  TextEditingController _vehicleNo = TextEditingController();
  TextEditingController _vehicleType = TextEditingController();
  TextEditingController _status = TextEditingController();
  TextEditingController _dateTime = TextEditingController();
  TextEditingController _mReading = TextEditingController();
  TextEditingController _mPicture = TextEditingController();
  io.File? imageFile;
  bool detectingText = false;

  _QrCodeScanPageState();

  final SpeechToText speechToText = SpeechToText();
  bool enabledSpeech = false;
  String _lastWords = '';

  void initSpeech() async {
    enabledSpeech = await speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _mReading.text = result.recognizedWords;
      if (_mReading.text.contains(' ')) {
        _mReading.text.replaceAll(' ', '');
      }
      if (int.tryParse(_mReading.text) == null) {
        _mReading.text = '';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _vehicleNo.text = widget.code ?? '';
    // _vehicleNo.text = widget.code.split(' ')[0] ?? '';
    _vehicleNo.text = _vehicleNo.text.toUpperCase();
    _status.text = widget.type ?? '';
    // _dateTime.text =
    //     DateFormat('dd-M-yyyy').format(DateTime.now()).toUpperCase();
    initSpeech();
    _dateTime.text =
        DateFormat('dd-MMM-yyyy HH:mm:ss').format(DateTime.now()).toUpperCase();
  }

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKeyGlobal,
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Center(
            child: Text(
          'QR Code Scan Form',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: _loading
          ? Container(
              color: Colors.grey.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  // size: 50.0,
                ),
              ),
            )
          : SingleChildScrollView(
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
                          'Vehicle Information',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
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
                        child: Text('Vehicle No',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Container(
                        width: width * 0.5,
                        height: height * 0.045,
                        padding: EdgeInsets.only(top: 2, right: 20),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          readOnly: true,
                          controller: _vehicleNo,
                          maxLength: 12,
                          // keyboardType: TextInputType.multiline,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 7),
                            // isCollapsed: true,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red.shade900),
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     Container(
                  //       padding: EdgeInsets.only(left: 8),
                  //       child: Text('Vehicle Type',
                  //           style: TextStyle(fontWeight: FontWeight.bold)),
                  //     ),
                  //     Container(
                  //       width: width * 0.5,
                  //       height: height * 0.04,
                  //       padding: EdgeInsets.only(top: 2, right: 20),
                  //       child: TextField(
                  //         textAlignVertical: TextAlignVertical.center,
                  //         textAlign: TextAlign.start,
                  //         maxLines: 1,
                  //         readOnly: true,
                  //         controller: _vehicleType,
                  //         // keyboardType: TextInputType.multiline,
                  //         style: TextStyle(
                  //             fontSize: 20, fontWeight: FontWeight.bold),
                  //         decoration: InputDecoration(
                  //           contentPadding: EdgeInsets.only(left: 7),
                  //           // isCollapsed: true,
                  //           border: OutlineInputBorder(),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderSide:
                  //                 BorderSide(color: Colors.red.shade900),
                  //           ),
                  //         ),
                  //
                  //         inputFormatters: [UpperCaseText()],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: height * 0.023,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        child: Text('Status',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                      ),
                      Container(
                        width: width * 0.5,
                        height: height * 0.045,
                        padding: EdgeInsets.only(top: 2, right: 20),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          readOnly: true,
                          controller: _status,
                          // keyboardType: TextInputType.multiline,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 7),
                            // isCollapsed: true,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red.shade900),
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
                        child: Text('Date Time (' + widget.type + ')',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Container(
                        width: width * 0.5,
                        height: height * 0.045,
                        padding: EdgeInsets.only(top: 2, right: 20),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          readOnly: true,
                          controller: _dateTime,
                          // keyboardType: TextInputType.multiline,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 7),
                            // isCollapsed: true,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red.shade900),
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
                        child: Text('Meter Reading',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      // speechToText.isListening
                      //     ? Padding(
                      //         padding: const EdgeInsets.only(right: 58.0),
                      //         child: SpinKitCircle(
                      //           color: Colors.grey,
                      //         ),
                      //       )
                      //     : Padding(
                      //         padding: const EdgeInsets.only(right: 20.0),
                      //         child: ElevatedButton(
                      //           onPressed: () async {
                      //             if (speechToText.isNotListening) {
                      //               _startListening();
                      //             }
                      //             setState(() {});
                      //           },
                      //           child: Text(
                      //             'Read Meter',
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 16,
                      //             ),
                      //           ),
                      //           style: ElevatedButton.styleFrom(
                      //             backgroundColor: Colors.grey.shade300,
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(8),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      Row(
                        children: [
                          if (_mReading.text.isNotEmpty) ...{
                            IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  size: 38,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _mReading.text = '';
                                    // imageFile = null;
                                  });
                                }),
                          },
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              speechToText.isNotListening
                                  ? Icons.mic_off
                                  : Icons.mic,
                              size: 50,
                            ),
                            onPressed: speechToText.isNotListening
                                ? _startListening
                                : _stopListening,
                          ),
                          Container(
                            width: width * 0.38,
                            height: height * 0.045,
                            padding: EdgeInsets.only(top: 2, right: 20),
                            child: TextField(
                              // onTap: () {
                              //   if(_mReading.text.trim().length == 0){
                              //     // gives error message
                              //   }
                              // },
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              readOnly: true,
                              controller: _mReading,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade900),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(),
                                // isCollapsed: true,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red.shade900),
                                ),
                              ),

                              inputFormatters: [UpperCaseText()],
                            ),
                          ),
                        ],
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
                        child: Text('Meter Picture',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      imageFile?.path.isEmpty ?? true
                          ? Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Container(
                                width: 155,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(20)),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: TextButton(
                                    onPressed: () async {
                                      if (_mReading.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    16.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    16.0))),
                                                content:
                                                    (Row(children: <Widget>[
                                                  Icon(
                                                    Icons.warning_rounded,
                                                    color: Colors.red.shade700,
                                                  ),
                                                  Text(
                                                      "   Please Enter The Meter Reading First")
                                                ]))));
                                        return;
                                      }
                                      await textDetect();
                                      // await takePicture();
                                      // _mReading.text = "132";
                                      setState(() {});
                                    },
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'Capture Meter',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Row(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.cancel_outlined, size: 38),
                                    onPressed: () async {
                                      setState(() {
                                        imageFile = null;
                                        _mReading.text = '';
                                      });
                                    }),
                                ClipOval(
                                  child: Container(
                                      width: width * 0.41,
                                      height: height * 0.2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(70),
                                      ),
                                      child: Image.file(imageFile!)),
                                ),
                              ],
                            ),
                    ],
                  ),
                  SizedBox(
                    height: imageFile?.path.isEmpty ?? true
                        ? height * 0.3
                        : height * 0.23,
                  ),
                  Container(
                    width: 120,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      onPressed: () async {
                        if (_vehicleNo.text.isEmpty ||
                            _mReading.text.isEmpty ||
                            imageFile == null ||
                            // _dateTime.text.isEmpty ||
                            _status.text.isEmpty) {
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
                                Text("   Please Fill All The Fields")
                              ]))));
                        } else {
                          try {
                            String count = '';
                            var response = await http.get(
                              Uri.parse('http://144.126.197.51:5000/getcarmax' +
                                  _status.text.toLowerCase().toString()),
                              headers: {'Content-Type': 'application/json'},
                            );
                            SharedPreferences sharedPreference =
                                await SharedPreferences.getInstance();
                            String uName =
                                sharedPreference.getString('userid') ?? '';

                            if (jsonDecode(response.body)['results'][0] ==
                                null) {
                              count = '1';
                            } else {
                              count =
                                  (jsonDecode(response.body)['results'][0] + 1)
                                      .toString();
                            }
                            List<int> bytes = await io.File(imageFile!.path)
                                .readAsBytesSync();
                            String img64 = await base64.encode(bytes);
                            // String todaydate = DateTime.now();
                            // todaydate =
                            //     formatDate(todaydate, [dd, '-', M, '-', yyyy]);
                            // todaydate = todaydate.toString().toUpperCase();
                            Map<String, dynamic> body = {
                              'trans_id': count,
                              'qrcode': _vehicleNo.text,
                              'km_' + _status.text.toLowerCase():
                                  _mReading.text,
                              'km_' + _status.text.toLowerCase() + '_image':
                                  img64.toString(),
                              'status': _status.text,
                              'create_by': uName,
                              'create_date': _dateTime.text,
                            };
                            response = await http.post(
                                Uri.parse('http://144.126.197.51:5000/postcar' +
                                    _status.text.toLowerCase().toString()),
                                body: body);
                            print('response: ${response.body}');
                            if (response.statusCode == 200) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => PopScope(
                                    canPop: false,
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
                                            'Successfully Saved',
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
                            } else if (response.statusCode == 500 ||
                                response.statusCode == 404) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16.0),
                                              topRight: Radius.circular(16.0))),
                                      content: (Row(children: <Widget>[
                                        Icon(
                                          Icons.warning_rounded,
                                          color: Colors.red.shade700,
                                        ),
                                        Text(
                                            "An Error Occured Upon Submitting Form")
                                      ]))));
                            }

                            setState(() {
                              _loading = false;
                            });
                          } catch (e) {
                            setState(() {
                              _loading = false;
                            });
                            print('error whilst submitting ' +
                                widget.type +
                                ' Report\nError: $e');
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
                                  Text('     error whilst submitting ' +
                                      widget.type +
                                      ' Report')
                                ]))));
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> textDetect() async {
    ImagePicker imagePicker = new ImagePicker();
    try {
      XFile? file = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );
      // if (file != null) {
      //   imageFile = io.File(file.path);
      //   // setState(() {});
      // }
      // if (file == null) return;
      // final inputImage = InputImage.fromFile(io.File(file?.path ?? ''));
      // final textRecognizer = TextRecognizer();
      // RecognizedText recognisedText = await textRecognizer
      //     .processImage(InputImage.fromFilePath(file!.path));
      // await textRecognizer.close();
      // print(
      //     '=============================================================================================================================================='
      //     '=================${recognisedText.text.split('\n')}');
      // if (recognisedText.text.isNotEmpty) {
      //   recognisedText.text.split('\n').forEach((val) {
      //     print('valueee::: $val');
      //     if (val.contains(' ')) {
      //       List<String> newVal = val.split(' ');
      //       val = '';
      //       newVal.forEach((_val) {
      //         val = val + _val;
      //       });
      //     }
      //     if (val.length > 4 && int.tryParse(val) != null) {
      //       _mReading.text = val;
      //     }
      //   });
      //   if (_mReading.text.isNotEmpty && file != null) {
      imageFile = io.File(file!.path);
      img.Image? image = img.decodeImage(imageFile!.readAsBytesSync());

      img.Image resizedImage = img.copyResize(image!, width: 300, height: 300);
      List<int> resizedImageBytes = img.encodeJpg(resizedImage, quality: 50);

      imageFile = io.File('${imageFile!.path}_resized.jpg');
      await imageFile!.writeAsBytes(resizedImageBytes);

      setState(() {});
    } catch (e) {
      print('error while text recognitions: $e');
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
            Text(
              "An Error Occurred While Detecting Mileage Meter",
              style: TextStyle(fontSize: 10),
            )
          ]))));
      detectingText = false;
      setState(() {});
    }
  }
}
