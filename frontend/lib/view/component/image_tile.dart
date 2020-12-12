import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  String profileImageUrl;
  String userName;
  String birthday;


  ImageTile({String profileImageUrl, String userName, String birthday}) {
    this.profileImageUrl = profileImageUrl;
    this.userName = userName;
    this.birthday = birthday;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(this.profileImageUrl), // no matter how big it is, it won't overflow
        ),
        title: Text(this.birthday),
        subtitle: Text(this.userName));
  }
}
