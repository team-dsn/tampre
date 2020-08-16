import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

class EventItem extends EventInterface {
  final DateTime date;
  final String title;
  final Widget icon;
  final String iconPath;
  final String wishList;
  final Widget dot;

  EventItem({
    this.date,
    this.title,
    this.icon,
    this.iconPath,
    this.wishList,
    this.dot,
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
