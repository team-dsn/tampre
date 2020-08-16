import 'package:flutter/material.dart';
import 'package:tampre/view/component/user.dart';

class HomeModel extends ChangeNotifier {
  List<User> users = [
    User(id: '1', userName: 'アリストテレス', birthday: '8/10', icon: 'images/aristoteres.png'),
    User(id: '2', icon: 'images/newton.jpeg', userName: 'ニュートン', birthday: '12/25'),
  ];
}