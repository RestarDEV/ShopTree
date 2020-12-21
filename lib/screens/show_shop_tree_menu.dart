import 'package:flutter/material.dart';
import 'package:treeshop/model/user_model.dart';

class ShowShopTreeMenu extends StatefulWidget {
  final UserModel userModel;
  ShowShopTreeMenu({Key key, this.userModel}) : super(key: key);
  @override
  _ShowShopTreeMenuState createState() => _ShowShopTreeMenuState();
}

class _ShowShopTreeMenuState extends State<ShowShopTreeMenu> {
  UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userModel.nameShop),
      ),
    );
  }
}
