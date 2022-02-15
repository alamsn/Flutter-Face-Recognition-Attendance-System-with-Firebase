import 'package:cloud_firestore/cloud_firestore.dart';
import 'button_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/pages/db_presensi_screen.dart';

class DatetimePickerWidget extends StatefulWidget {
  // static String id = 'DatetimePicker';
  final DateTime previousDate;
  DatetimePickerWidget({this.previousDate});
  @override
  _DatetimePickerWidgetState createState() => _DatetimePickerWidgetState();
}

class _DatetimePickerWidgetState extends State<DatetimePickerWidget> {
  DateTime dateTime;
  Timestamp stamp;

  String getText() {
    if (dateTime == null) {
      return 'Pilih waktu';
    } else {
      return DateFormat('dd-MM-yyyy hh:mm').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        title: 'DateTime',
        text: getText(),
        onClicked: () => pickDateTime(context),
      );

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      stamp = Timestamp.fromDate(dateTime);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DBScreen(
            timeStamp: stamp,
          ),
        ),
      );
      print(stamp);
    });
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }
}
