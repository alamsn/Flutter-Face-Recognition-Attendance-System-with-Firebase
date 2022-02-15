import 'package:flutter/material.dart';

class User {
  String user;

  User({@required this.user});

  static User fromDB(String dbuser) {
    return new User(user: dbuser.split(':')[0]);
  }
}
