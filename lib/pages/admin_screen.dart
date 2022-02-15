import 'package:flutter/material.dart';
import '/pages/widgets/custom_icon.dart';
import '/pages/widgets/custom_card.dart';
import '/pages/db_presensi_screen.dart';
import '/pages/registration_screen.dart';
import '/pages/login_screen.dart';
import '/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminScreen extends StatefulWidget {
  static String id = 'Admin_Screen';
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScafoldBackColor,
        title: Text('Admin'),
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
                    // colour: kIconButtonColor,
                    onPress: () {
                      setState(() {});
                    },
                    cardChild: CustomIcon(
                      icon: FontAwesomeIcons.userPlus,
                      label: 'Tambah User',
                      colour: kIconButtonColor,
                      onPress: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    // colour: kIconButtonColor,
                    onPress: () {
                      setState(() {});
                    },
                    cardChild: CustomIcon(
                      icon: FontAwesomeIcons.database,
                      label: 'Database',
                      colour: kIconButtonColor,
                      onPress: () {
                        setState(() {
                          Navigator.pushNamed(context, DBScreen.id);
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
