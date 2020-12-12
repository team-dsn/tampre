import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  String icon;
  String userName;
  String birthday;


  ImageTile({String icon, String userName, String birthday}) {
    this.icon = icon;
    this.userName = userName;
    this.birthday = birthday;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(this.icon), // no matter how big it is, it won't overflow
        ),
        title: Text(this.birthday),
        subtitle: Text(this.userName));
  }
}
