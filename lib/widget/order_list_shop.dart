import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treeshop/model/user_model.dart';
import 'package:treeshop/utility/my_constant.dart';

class OrderLisShop extends StatefulWidget {
  @override
  _OrderLisShopState createState() => _OrderLisShopState();
}

class _OrderLisShopState extends State<OrderLisShop> {

  UserModel userModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'แสดงรายการต้นไม้ ที่ลูกค้าสั่ง'
    );
  }
}