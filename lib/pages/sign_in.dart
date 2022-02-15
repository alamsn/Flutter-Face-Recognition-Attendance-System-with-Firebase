import '/services/database.dart';
import 'pengenalan_wajah.dart';
// import '/pages/sign-up.dart';
import '/pages/user_screen.dart';
import '../services/face.service.dart';
import '/services/ml_kit_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class SignIn extends StatefulWidget {
  static String id = 'SignIn_Pages';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Services injection
  FaceModelService _faceService = FaceModelService();
  MLKitService _mlKitService = MLKitService();
  DataBaseService _dataBaseService = DataBaseService();

  CameraDescription cameraDescription;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _startUp();
  }

  /// 1 Obtain a list of the available cameras on the device.
  /// 2 loads the face model
  _startUp() async {
    _setLoading(true);

    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection == CameraLensDirection.front,
    );

    // start the services
    await _faceService.loadModel();
    await _dataBaseService.loadDB();
    _mlKitService.initialize();

    _setLoading(false);
  }

  // shows or hides the circular progress indicator
  _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  // void _launchURL() async => await canLaunch(githubURL)
  //     ? await launch(githubURL)
  //     : throw 'Could not launch $githubURL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: MaterialButton(
              child: Icon(
                Icons.home,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  Navigator.pushNamed(context, UserScreen.id);
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: PopupMenuButton<String>(
              child: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (value) {
                switch (value) {
                  case 'Clear DB':
                    _dataBaseService.cleanDB();
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Clear DB'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
      body: !loading
          ? SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image(
                      image: AssetImage('images/logo.png'),
                      height: 150,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          Text(
                            "PENGUJIAN MODEL FACE RECOGNITION ",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Text(
                          //   "Pengujian model face recognition pada perangkat mobile",
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //   ),
                          //   textAlign: TextAlign.center,
                          // ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PresensiScreen(
                                  cameraDescription: cameraDescription,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  blurRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Kenali Wajah',
                                  style: TextStyle(color: Color(0xFF0F0BDB)),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.login, color: Color(0xFF0F0BDB))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (BuildContext context) => SignUp(
                        //           cameraDescription: cameraDescription,
                        //         ),
                        //       ),
                        //     );
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       color: Color(0xFF0F0BDB),
                        //       boxShadow: <BoxShadow>[
                        //         BoxShadow(
                        //           color: Colors.blue.withOpacity(0.1),
                        //           blurRadius: 1,
                        //           offset: Offset(0, 2),
                        //         ),
                        //       ],
                        //     ),
                        //     alignment: Alignment.center,
                        //     padding: EdgeInsets.symmetric(
                        //         vertical: 14, horizontal: 16),
                        //     width: MediaQuery.of(context).size.width * 0.8,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Text(
                        //           'Tambah Wajah',
                        //           style: TextStyle(color: Colors.white),
                        //         ),
                        //         SizedBox(
                        //           width: 10,
                        //         ),
                        //         Icon(Icons.person_add, color: Colors.white)
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
