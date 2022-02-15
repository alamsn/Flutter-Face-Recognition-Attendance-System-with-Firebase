import '/services/database.dart';
import '/pages/models/user.model.dart';
import '/pages/data_presensi_screen.dart';
import '/pages/widgets/app_button.dart';
// import '/services/camera.service.dart';
import '../../services/face.service.dart';
import 'package:flutter/material.dart';
import '../sign_in.dart';
import 'app_text_field.dart';

class AuthActionButton extends StatefulWidget {
  AuthActionButton(this._initializeControllerFuture,
      {Key key, @required this.onPressed, @required this.isKnown, this.reload});
  final Future _initializeControllerFuture;
  final Function onPressed;
  final bool isKnown;
  final Function reload;

  @override
  _AuthActionButtonState createState() => _AuthActionButtonState();
}

class _AuthActionButtonState extends State<AuthActionButton> {
  /// service injection
  final FaceModelService _faceService = FaceModelService();
  final DataBaseService _dataBaseService = DataBaseService();
  final TextEditingController _userTextEditingController =
      TextEditingController(text: '');

  User predictedUser;

  Future _signUp(context) async {
    /// gets predicted data from facenet service (user face detected)
    List predictedData = _faceService.predictedData;
    String user = _userTextEditingController.text;
    // String password = _passwordTextEditingController.text;

    /// creates a new user in the 'database'
    await _dataBaseService.saveData(user, predictedData);

    /// resets the face stored in the face sevice
    this._faceService.setPredictedData(null);
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => SignIn()));
  }

  Future _signIn(context) async {
    // String user = _userTextEditingController.text;
    Navigator.pushNamed(context, DataPresensiScreen.id);
  }

  String _predictUser() {
    String userLog = _faceService.predict();
    return userLog ?? null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          // Ensure that the camera is initialized.
          await widget._initializeControllerFuture;
          // onShot event (takes the image and predict output)
          bool faceDetected = await widget.onPressed();

          if (faceDetected) {
            if (widget.isKnown) {
              var userLog = _predictUser();
              if (userLog != null) {
                this.predictedUser = User.fromDB(userLog);
              }
            }
            PersistentBottomSheetController bottomSheetController =
                Scaffold.of(context)
                    .showBottomSheet((context) => signSheet(context));

            bottomSheetController.closed.whenComplete(() => widget.reload());
          }
          print(predictedUser.user);
        } catch (e) {
          // If an error occurs, log the error to the console.
          print(e);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF0F0BDB),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TEKAN',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.camera_alt, color: Colors.white)
          ],
        ),
      ),
    );
  }

  signSheet(context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isKnown && predictedUser != null
              ? Center(
                  child: Container(
                    child: Text(
                      '${predictedUser.user}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              : widget.isKnown
                  ? Center(
                      child: Container(
                          child: Text(
                        'Wajah tidak dikenali',
                        style: TextStyle(fontSize: 20),
                      )),
                    )
                  : Container(),
          Container(
            child: Column(
              children: [
                !widget.isKnown
                    ? AppTextField(
                        controller: _userTextEditingController,
                        labelText: "Nama",
                      )
                    : Container(),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                widget.isKnown && predictedUser != null
                    ? AppButton(
                        text: 'Cek',
                        onPressed: () async {
                          _signIn(context);
                        },
                        icon: Icon(
                          Icons.login,
                          color: Colors.white,
                        ),
                      )
                    : !widget.isKnown
                        ? AppButton(
                            text: 'Tambah',
                            onPressed: () async {
                              await _signUp(context);
                            },
                            icon: Icon(
                              Icons.person_add,
                              color: Colors.white,
                            ),
                          )
                        : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
