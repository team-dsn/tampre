import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

import 'package:tampre/view/component/global.dart' as global;

class CalendarModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  EventList<Event> markedDateMap = new EventList<Event>();

  CalendarModel(){
    global.users.forEach((user) {
      print(user.birthday.month);
      print(user.birthday.day);
      markedDateMap.addAll(new DateTime(2020, user.birthday.month, user.birthday.day), [
        new Event(
          date: new DateTime(2020, 8, 18),
          title: 'Event 2',
          icon: Container(
            decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(1000)),
            border: Border.all(color: Colors.blue, width: 2.0)),
            child: new CircleAvatar(
              backgroundImage: AssetImage(user.icon),
            ),
          ),
        ),
      ]);
    });
  }

  void onDayPressed(DateTime date, List<Event> events) {
    currentDate = date;
    Fluttertoast.showToast(msg: date.toString());
    notifyListeners();
  }
}
