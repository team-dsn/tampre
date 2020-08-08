import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  Widget build(BuildContext context) {
  return TableCalendar(
    calendarController: _calendarController,
  );
}

/*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("カレンダー"),
      ),
      body: Center(child: Text("カレンダー")),
    );
  }
}
*/
