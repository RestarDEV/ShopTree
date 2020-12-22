import 'package:flutter/material.dart';
import 'package:treeshop/model/user_model.dart';
import 'package:treeshop/utility/my_style.dart';
import 'package:treeshop/widget/about_shop.dart';
import 'package:treeshop/widget/show_menu_tree.dart';

class ShowShopTreeMenu extends StatefulWidget {
  final UserModel userModel;
  ShowShopTreeMenu({Key key, this.userModel}) : super(key: key);
  @override
  _ShowShopTreeMenuState createState() => _ShowShopTreeMenuState();
}

class _ShowShopTreeMenuState extends State<ShowShopTreeMenu> {
  UserModel userModel;
  List<Widget> listWigets = List();
  int indexPage = 0;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    listWigets.add(AboutShop(
      userModel: userModel,
    ));
    listWigets.add(ShowMenuTree(
      userModel: userModel,
    ));
  }

  BottomNavigationBarItem aboutShopNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      title: Text('รายละเอียดร้าน'),
    );
  }

  BottomNavigationBarItem showMenuTreeNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_menu),
      title: Text('เมนูต้นไม้'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userModel.nameShop),
      ),
      body: listWigets.length == 0
          ? MyStyle().showProgress()
          : listWigets[indexPage],
      //body: Text('Test'),
      bottomNavigationBar: ShowBottonNavigationBar(),
    );
  }

  BottomNavigationBar ShowBottonNavigationBar() => BottomNavigationBar(
        selectedItemColor: Colors.green,
        currentIndex: indexPage,
        onTap: (value) {
          setState(() {
            indexPage = value;
          });
        },
        items: <BottomNavigationBarItem>[
          aboutShopNav(),
          showMenuTreeNav(),
        ],
      );
}
