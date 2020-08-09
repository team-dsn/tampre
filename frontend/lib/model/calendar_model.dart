import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

class CalendarModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now();

  void onDayPressed(DateTime date, List<Event> events) {
    currentDate = date;
    Fluttertoast.showToast(msg: date.toString());
    notifyListeners();
  }
}
