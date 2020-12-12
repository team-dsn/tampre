import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tampre/model/wishList_register_model.dart';

class wishListMethod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WishListRegisterModel>(
        create: (_) => WishListRegisterModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('欲しいものリスト登録'),
          ),
          body: Consumer<WishListRegisterModel>(
            builder: (context, model, child) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: Container(
                          width: 30,
                          height: 30,
                          child: Text('1'),
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blueGrey
                          ),
                        ),
                        title: Text('step1',
                          style: TextStyle(
                            fontSize: 25,
                          )
                        ),
                        subtitle: Text('amazonにログイン')
                    ),
                    Image.asset('images/wishList1.png'),
                    Text('step2'),
                    Image.asset('images/wishList2.png'),
                    Text('step3'),
                    Image.asset('images/wishList3.png'),
                    Text('step4'),
                    Image.asset('images/wishList4.png'),
                    Text('step5'),
                    Image.asset('images/wishList5.png'),
                    Text('step6'),
                    Image.asset('images/wishList6.png'),
                    Text('step7'),
                    Image.asset('images/wishList7.png'),
                    Text('step8'),
                    Image.asset('images/wishList8.png'),
                    Text('step9'),
                    Image.asset('images/wishList9.png'),
                    Text('step10'),
                    Image.asset('images/wishList10.png'),
                    Text('step11'),
                    Image.asset('images/wishList11.png'),
                    Text('step12'),
                    Image.asset('images/wishList12.png'),
                  ],
                ),
              );
            }
        )
      )
    );
  }
}