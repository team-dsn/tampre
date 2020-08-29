import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/classes/event_list.dart';

import 'package:tampre/view/component/event_item.dart';
import 'package:tampre/view/component/global.dart' as global;
import 'package:tampre/view/component/user.dart';
import 'package:tampre/view/friend_profile.dart';
import 'package:tampre/view/home_route.dart';
import 'package:tampre/view/profile_route.dart';

class CalendarModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  EventList<EventItem> markedDateMap = new EventList<EventItem>();

  CalendarModel(){
    global.users.forEach((user) {
      markedDateMap.addAll(new DateTime(2020, user.birthday.month, user.birthday.day), [
        new EventItem(
          user: user,
          date: new DateTime(2020, user.birthday.month, user.birthday.day),
          title: user.userName,
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

  void onDayPressed(DateTime date, List<EventItem> events, BuildContext context) {
    if(events.length == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FriendProfile(
            user: events[0].user,
          ),
        )
      );
    } else if (1 < events.length) {
      List<User> users = [];
      events.forEach((event) {
        users.add(event.user);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home.users(
            users: users,
          ),
        )
      );
    }
    currentDate = date;
    notifyListeners();
  }
}
