import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treeshop/utility/my_style.dart';
import 'package:treeshop/utility/signout_process.dart';
import 'package:treeshop/widget/information_shop.dart';
import 'package:treeshop/widget/list_tree_menu_shop.dart';
import 'package:treeshop/widget/order_list_shop.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  //Field
  Widget currentWidget = OrderLisShop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Shop'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => signOutProcess(context))
        ],
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
            homeMenu(),
            treeMenu(),
            infomationMenu(),
            signOutMenu(),
          ],
        ),
      );

  ListTile homeMenu() => ListTile(
        leading: Icon(Icons.home),
        title: Text('รายการต้นไม้ที่ลูกค้าสั่ง'),
        subtitle: Text('รายการต้นไม้ที่ยังไม่ได้ทำส่ง'),
        onTap: () {
          setState(() {
            currentWidget = OrderLisShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile treeMenu() => ListTile(
        leading: Icon(Icons.fastfood),
        title: Text('รายการต้นไม้'),
        subtitle: Text('รายการต้นไม้'),
        onTap: () {
          setState(() {
            currentWidget = ListTreeMentShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile infomationMenu() => ListTile(
        leading: Icon(Icons.info),
        title: Text('รายละเอียด ของร้าน'),
        subtitle: Text('รายละเอียด ของร้าน พร้อม Edit'),
        onTap: () {
          setState(() {
            currentWidget = InformationShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile signOutMenu() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Sign Out'),
        subtitle: Text('Sign Out'),
        onTap: () => signOutProcess(context),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('shop.png'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text('Name Shop'),
      accountEmail: Text('Login'),
    );
  }
}
