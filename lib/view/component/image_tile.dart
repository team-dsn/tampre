import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  String icon;
  String username;
  String birthday;

  ImageTile({String icon, String username, String birthday}) {
    this.icon = icon;
    this.username = username;
    this.birthday = birthday;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(this.icon), // no matter how big it is, it won't overflow
        ),
        title: Text(this.birthday),
        subtitle: Text(this.username));
  }
}
