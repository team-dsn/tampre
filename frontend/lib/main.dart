import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:tampre/view/component/global.dart' as global;
import 'package:tampre/view/footer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  print(global.icons);
  global.icons = 'piyo';
  await loadJsonAsset();
  print(global.icons);
  runApp(App());
}

Future<void> loadJsonAsset() async {
  String loadData = await rootBundle.loadString('json/data.json');
  final jsonResponse = json.decode(loadData);
  jsonResponse.forEach((key,value) {
    global.icons = '$value';
  });
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tampre',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey[900],
      ),
      home: FooterWidget(),
    );
  }
}
