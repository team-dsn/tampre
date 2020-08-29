import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:provider/provider.dart';

import 'package:tampre/model/calendar_model.dart';
import 'package:tampre/view/component/event_item.dart';

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
            return CalendarCarousel<EventItem>(
              onDayPressed: (date, events) => model.onDayPressed(date, events, context),
              weekendTextStyle: TextStyle(color: Colors.red),
              weekFormat: false,
              height: MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight,
              selectedDateTime: model.currentDate,
              daysHaveCircularBorder: null,
              customGridViewPhysics: NeverScrollableScrollPhysics(),
              markedDateShowIcon: true,
              markedDateIconMaxShown: 2,
              todayTextStyle: TextStyle(
                color: Colors.white,
              ),
              todayButtonColor: Colors.blue,
              markedDateIconBuilder: (event) {
                return event.icon;
              },
              todayBorderColor: Colors.transparent,
              selectedDayBorderColor: Colors.transparent,
              selectedDayButtonColor: Colors.blue[200],
              markedDateMoreShowTotal: false,
              markedDatesMap: model.markedDateMap,
            );
          },),
        ),
      )
    );
  }
}
