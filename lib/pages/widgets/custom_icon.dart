import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/constants.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({this.icon, this.label, this.onPress, this.colour});

  final IconData icon;
  final Color colour;
  final String label;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: FaIcon(
              icon,
              color: colour,
            ),
            iconSize: 70,
            onPressed: onPress),
        SizedBox(height: 15),
        Text(
          label,
          style: kLabelTextStyle,
        )
      ],
    );
  }
}
