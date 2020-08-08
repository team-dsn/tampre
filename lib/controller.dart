import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'view/calendar_route.dart';
import 'view/friend_add_route.dart';
import 'view/home_route.dart';
import 'view/profile_route.dart';

class ControllerWidget extends StatefulWidget {
  ControllerWidget({Key key}) : super(key: key);

  @override
  _ControllerWidgetState createState() => _ControllerWidgetState();
}

class _ControllerWidgetState extends State<ControllerWidget> {
  int _selectedIndex = 0;
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];

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

  // === 追加部分 ===
  var _routes = [
    Home(),
    Calendar(),
    FriendAdd(),
    Profile(),
  ];
  // ==============

  @override
  void initState() {
    super.initState();
    int initialIndex = 0;
    _bottomNavigationBarItems.add(_updateActiveState(initialIndex));
    for (var i = 1; i < _footerItemNames.length; i++) {
      _bottomNavigationBarItems.add(_updateDeactiveState(i));
    }
    _selectedIndex = initialIndex;
  }

  /// インデックスのアイテムをアクティベートする
  BottomNavigationBarItem _updateActiveState(int index) {
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

  BottomNavigationBarItem _updateDeactiveState(int index) {
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

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavigationBarItems[_selectedIndex] =
          _updateDeactiveState(_selectedIndex);
      _bottomNavigationBarItems[index] = _updateActiveState(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _routes.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
