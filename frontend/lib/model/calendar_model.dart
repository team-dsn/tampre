import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;


class CalendarModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  EventList<Event> markedDateMap = new EventList<Event>();
  static Widget eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  CalendarModel(){
    markedDateMap.addAll(new DateTime(2020, 8, 11), [
      new Event(
        date: new DateTime(2020, 8, 11),
        title: 'Event 1',
        icon: eventIcon,
      ),
      new Event(
        date: new DateTime(2020, 8, 11),
        title: 'Event 2',
        icon: eventIcon,
      ),
      new Event(
        date: new DateTime(2020, 8, 11),
        title: 'Event 2',
        icon: eventIcon,
      ),
      new Event(
        date: new DateTime(2020, 8, 12),
        title: 'Event 2',
        icon: eventIcon,
      ),
      new Event(
        date: new DateTime(2020, 8, 13),
        title: 'Event 2',
        icon: eventIcon,
      ),
    ]);
    markedDateMap.addAll(new DateTime(2020, 8, 12), [
      new Event(
        date: new DateTime(2020, 8, 11),
        title: 'Event 1',
        icon: eventIcon,
      ),
      new Event(
        date: new DateTime(2020, 8, 13),
        title: 'Event 2',
        icon: eventIcon,
      ),
      new Event(
        date: new DateTime(2020, 8, 13),
        title: 'Event 2',
        icon: eventIcon,
      ),
    ]);
    markedDateMap.addAll(new DateTime(2020, 8, 13), [
      new Event(
        date: new DateTime(2020, 8, 11),
        title: 'Event 1',
        icon: eventIcon,
      ),
      new Event(
        date: new DateTime(2020, 8, 13),
        title: 'Event 2',
        icon: eventIcon,
      ),
    ]);
    markedDateMap.addAll(new DateTime(2020, 8, 14), [
      new Event(
        date: new DateTime(2020, 8, 11),
        title: 'Event 1',
        icon: eventIcon,
      ),
    ]);
  }

  void onDayPressed(DateTime date, List<Event> events) {
    currentDate = date;
    Fluttertoast.showToast(msg: date.toString());
    notifyListeners();
  }
}
