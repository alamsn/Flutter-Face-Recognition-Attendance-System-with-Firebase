import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'hint',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kBottomContainerHeight = 90.0;
const kBottomContainerColor = Color(0xFFEB1555);
const kActiveCardColor = Color(0xFFEB1555);
const kInactiveCardColor = Color(0xFF1F1F33);
const kIconActiveColor = Colors.black;
const kMainColor = Color(0xFF0A0D22);
const kSecondColor = Color(0xFFFF6BCB);
const kScafoldBackColor = Colors.lightBlue;
const kSliderActiveColor = Color(0xFFEB1555);
const kSliderOverlayColor = Color(0x55EB1555);
const kSliderInactiveColor = Color(0xFF8D8E98);
const kIconButtonColor = Colors.lightBlue;

const kLabelTextStyle = TextStyle(
  fontSize: 20,
  color: kIconActiveColor,
);

const kNumberTextStyle = TextStyle(
  fontSize: 60,
  color: Colors.white,
  fontWeight: FontWeight.w900,
);

const kCalculateTextStyle = TextStyle(
  fontSize: 30,
  color: Colors.white,
  fontWeight: FontWeight.w700,
);

const kGreenTextStyle = TextStyle(
  color: Colors.green,
  fontWeight: FontWeight.w400,
  fontSize: 25,
);

const kBMIScoreTextStyle = TextStyle(
  fontSize: 120,
  color: Colors.white,
  fontWeight: FontWeight.w900,
);
