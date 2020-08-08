import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:tampre/view/calendar_route.dart';
import 'package:tampre/view/friend_add_route.dart';
import 'package:tampre/view/home_route.dart';
import 'package:tampre/view/profile_route.dart';

class FooterModel extends ChangeNotifier {
  int selectedIndex = 0;
  final bottomNavigationBarItems = <BottomNavigationBarItem>[];

  FooterModel() {
    bottomNavigationBarItems.add(updateActiveState(selectedIndex));
    for (var i = 1; i < _footerItemNames.length; i++) {
      bottomNavigationBarItems.add(updateDeactiveState(i));
    }
  }

  static const _footerIcons = [
    Icons.home,
    Icons.calendar_today,
    Icons.person_add,
    Icons.person,
  ];

  static const _footerItemNames = [
    'ホーム',
    'カレンダー',
    '友達追加',
    'プロフィール',
  ];

  var routes = [
    Home(),
    Calendar(),
    FriendAdd(),
    Profile(),
  ];

  BottomNavigationBarItem updateActiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.black87,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(
            color: Colors.black87,
          ),
        ));
  }

  BottomNavigationBarItem updateDeactiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.black26,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(
            color: Colors.black26,
          ),
        ));
  }

  void onItemTapped(int index) {
    bottomNavigationBarItems[selectedIndex] =
        updateDeactiveState(selectedIndex);
    bottomNavigationBarItems[index] = updateActiveState(index);
    selectedIndex = index;
    notifyListeners();
  }
}
