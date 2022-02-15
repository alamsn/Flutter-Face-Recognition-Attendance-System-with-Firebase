import 'package:flutter/material.dart';
import '/pages/login_screen.dart';
import '../pages/widgets/custom_icon.dart';
import '../pages/widgets/custom_card.dart';
import '/constants.dart';
import 'sign_in.dart';
import '/pages/data_presensi_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserScreen extends StatefulWidget {
  static String id = 'User_Screen';
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScafoldBackColor,
        title: Text('Dosen'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: MaterialButton(
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  Navigator.pushNamed(context, LoginScreen.id);
                });
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CustomCard(
                    onPress: () {
                      setState(() {});
                    },
                    cardChild: CustomIcon(
                      icon: FontAwesomeIcons.camera,
                      label: 'Presensi',
                      colour: kIconButtonColor,
                      onPress: () {
                        Navigator.pushNamed(context, SignIn.id);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    onPress: () {
                      setState(() {});
                    },
                    cardChild: CustomIcon(
                      icon: FontAwesomeIcons.clipboard,
                      label: 'Riwayat',
                      colour: kIconButtonColor,
                      onPress: () {
                        setState(() {
                          Navigator.pushNamed(context, DataPresensiScreen.id);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
