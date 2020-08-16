import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:quartet/quartet.dart' show slice;

import 'package:tampre/view/component/event_item.dart';
import 'package:tampre/view/component/global.dart' as global;
import 'package:tampre/view/component/user.dart';
import 'package:tampre/view/profile_route.dart';

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

  void onDayPressed(DateTime date, List<EventItem> events, BuildContext context) {
    if(events.length == 1) {
      String month = slice('0' + events[0].date.month.toString(), -2);
      String day = slice('0' + events[0].date.day.toString(), -2);
      String birthday = '2020${month}${day}';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(
            user: User(
              id: '1',
              userName: events[0].title,
              birthday: birthday, 
              icon: events[0].iconPath,
              wishList: events[0].wishList
            )
          ),
        )
      );
    }
    currentDate = date;
    notifyListeners();
  }
}
