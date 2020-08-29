import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

import 'package:tampre/view/component/user.dart';

class EventItem extends EventInterface {
  final DateTime date;
  final String title;
  final Widget icon;
  final Widget dot;
  final User user;

  EventItem({
    this.date,
    this.title,
    this.icon,
    this.dot,
    this.user,
  }) : assert(date != null);

  @override
  bool operator ==(dynamic other) {
    return this.date == other.date &&
        this.title == other.title &&
        this.icon == other.icon &&
        this.dot == other.dot;
  }

  @override
  int get hashCode => hashValues(date, title, icon);

  @override
  DateTime getDate() {
    return date;
  }

  @override
  Widget getDot() {
    return dot;
  }

  @override
  Widget getIcon() {
    return icon;
  }

  @override
  String getTitle() {
    return title;
  }
}
