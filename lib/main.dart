import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/sign_in.dart';
import '/pages/login_screen.dart';
import '/pages/admin_screen.dart';
import '/pages/user_screen.dart';
import '/pages/data_presensi_screen.dart';
import '/pages/db_presensi_screen.dart';
import '/pages/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        AdminScreen.id: (context) => AdminScreen(),
        UserScreen.id: (context) => UserScreen(),
        DBScreen.id: (context) => DBScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        DataPresensiScreen.id: (context) => DataPresensiScreen(),
        SignIn.id: (context) => SignIn(),
      },
    );
  }
}
