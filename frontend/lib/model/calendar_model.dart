import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

import 'package:tampre/view/component/event_item.dart';
import 'package:tampre/view/component/global.dart' as global;

class CalendarModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  EventList<EventItem> markedDateMap = new EventList<EventItem>();

  CalendarModel(){
    global.users.forEach((user) {
      markedDateMap.addAll(new DateTime(2020, user.birthday.month, user.birthday.day), [
        new EventItem(
          date: new DateTime(2020, user.birthday.month, user.birthday.day),
          title: user.name,
          icon: Container(
            decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(1000)),
            border: Border.all(color: Colors.blue, width: 2.0)),
            child: new CircleAvatar(
              backgroundImage: AssetImage(user.icon),
            ),
          ),
          iconPath: user.icon,
          wishList: user.wishList
        ),
      ]);
    });
  }
}
