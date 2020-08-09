import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tampre/model/footer_model.dart';

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FooterModel>(
      create: (_) => FooterModel(),
      child: Scaffold(
        body: Consumer<FooterModel>(builder: (context, model, child) {
          return Center(child: model.routes.elementAt(model.selectedIndex));
        }),
        bottomNavigationBar:
            Consumer<FooterModel>(builder: (context, model, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: model.bottomNavigationBarItems,
            currentIndex: model.selectedIndex,
            onTap: model.onItemTapped,
          );
        }),
      ),
    );
  }
}
