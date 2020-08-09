import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:provider/provider.dart';

import 'package:tampre/model/calendar_model.dart';

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalendarModel>(
      create: (_) => CalendarModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("カレンダー"),
        ),
        body: Container(
          child: Consumer<CalendarModel>(builder: (context, model, child) {
            return CalendarCarousel<Event>(
              onDayPressed: model.onDayPressed,
              weekendTextStyle: TextStyle(color: Colors.red),
              thisMonthDayBorderColor: Colors.grey,
              weekFormat: false,
              height: MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight,
              selectedDateTime: model.currentDate,
              daysHaveCircularBorder: false,
              customGridViewPhysics: NeverScrollableScrollPhysics(),
              markedDateShowIcon: true,
              markedDateIconMaxShown: 2,
              todayTextStyle: TextStyle(
                color: Colors.blue,
              ),
              markedDateIconBuilder: (event) {
                return event.icon;
              },
              todayBorderColor: Colors.green,
              markedDateMoreShowTotal: false);
            },
          ),
        ),
      )
    );
  }
}
