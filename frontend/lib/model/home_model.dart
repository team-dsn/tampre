import 'package:flutter/material.dart';
import 'package:tampre/view/component/user.dart';

class HomeModel extends ChangeNotifier {
  List<User> users = [
    User(id: '1', userName: 'アリストテレス', birthday: '19970125', icon: 'images/aristoteres.png'),
    User(id: '2', icon: 'images/newton.jpeg', userName: 'ニュートン', birthday: '19921221'),
    User(id: '3', icon: 'images/newton.jpeg', userName: 'ニューロン', birthday: '20000211'),
    User(id: '4', icon: 'images/newton.jpeg', userName: 'ニューコメン', birthday: '20000311'),
    User(id: '5', icon: 'images/newton.jpeg', userName: 'ニューごめん', birthday: '20000411'),
    User(id: '6', icon: 'images/newton.jpeg', userName: 'ニューごめん', birthday: '20000511'),
    User(id: '7', icon: 'images/newton.jpeg', userName: 'ニューごめん', birthday: '20000611'),
    User(id: '8', icon: 'images/newton.jpeg', userName: 'ニューごめん', birthday: '20000711'),
    User(id: '9', icon: 'images/newton.jpeg', userName: 'ニューごめん', birthday: '20000811'),
    User(id: '10', icon: 'images/newton.jpeg', userName: 'ニューごめん', birthday: '20000911'),
    User(id: '11', icon: 'images/newton.jpeg', userName: 'ニューごめん', birthday: '20001011'),
    User(id: '12', icon: 'images/newton.jpeg', userName: 'ニューごめん', birthday: '20001111'),
  ];

  sort() {
    users.forEach((user) {
      int transformedDate = user.birthday.month * 100 + user.birthday.day;
      int transformedTodayDate = DateTime.now().month * 100 + DateTime.now().day;
      int gapmonth = 400; //ずらし分の月　今は3ヶ月
      transformedDate = transformedDate - transformedTodayDate + gapmonth;
      user.transformedDate =  (transformedDate < 101 ? transformedDate + 1200 : transformedDate);
    });

    Comparator<User> birthdayComparator = (a, b) =>
    a.transformedDate.compareTo(b.transformedDate);
    users.sort(birthdayComparator);
  }


}