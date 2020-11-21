import 'package:flutter/material.dart';
import 'package:tampre/view/component/user.dart';

class HomeModel extends ChangeNotifier {
  List<User> users;
  int afterbirthday = 0;
  HomeModel(this.users);

  sort() {
    users.forEach((user) {
      int transformedDate = user.birthday.month * 100 + user.birthday.day;
      int transformedTodayDate = DateTime.now().month * 100 + DateTime.now().day;
      int gapmonth = 400; //ずらし分の月　今は3ヶ月
      transformedDate = transformedDate - transformedTodayDate + gapmonth;
      user.transformedDate =  (transformedDate < 101 ? transformedDate + 1200 : transformedDate);
      if(user.transformedDate <= gapmonth){
        afterbirthday++ ;
        print(afterbirthday);
      }
    });
    Comparator<User> birthdayComparator = (a, b) =>
    a.transformedDate.compareTo(b.transformedDate);
    users.sort(birthdayComparator);
    notifyListeners();
  }


}
