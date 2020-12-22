import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:treeshop/model/tree_model.dart';
import 'package:treeshop/model/user_model.dart';
import 'package:treeshop/utility/my_api.dart';
import 'package:treeshop/utility/my_constant.dart';
import 'package:treeshop/utility/my_style.dart';

class ShowMenuTree extends StatefulWidget {
  final UserModel userModel;

  ShowMenuTree({Key key, this.userModel}) : super(key: key);
  @override
  _ShowMenuTreeState createState() => _ShowMenuTreeState();
}

class _ShowMenuTreeState extends State<ShowMenuTree> {
  UserModel userModel;
  String idShop;
  List<TreeModel> treeModels = List();
  int amount = 1;
  double lat1, lng1, lat2, lng2;
  Location location = Location();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
    readTreeMenu();
  }

  Future<Null> findLocation() async {
    location.onLocationChanged.listen((event) {
      lat1 = event.latitude;
      lng1 = event.longitude;
      // print('lat1 = $lat1, lng1 = $lng1');
    });
  }

  Future<Null> readTreeMenu() async {
    idShop = userModel.id;
    String url =
        '${MyConstant().domain}/treeshop/getTreeWhereIdShop.php?isAdd=true&idShop=$idShop';
    Response response = await Dio().get(url);
    // print('res ==> $response');

    var result = json.decode(response.data);
    // print('result = $result');

    for (var map in result) {
      TreeModel treeModel = TreeModel.fromJson(map);
      setState(() {
        treeModels.add(treeModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return treeModels.length == 0
        ? MyStyle().showProgress()
        : ListView.builder(
            itemCount: treeModels.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                // print('You Click index = $index');
                amount = 1;
                confirmOrder(index);
              },
              child: Row(
                children: <Widget>[
                  showTreeImage(context, index),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              treeModels[index].nameTree,
                              style: MyStyle().mainTitle,
                            ),
                          ],
                        ),
                        Text(
                          '${treeModels[index].price} บาท',
                          style: TextStyle(
                            fontSize: 30,
                            color: MyStyle().darkColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5 -
                                  18.0,
                              child: Text(treeModels[index].detail),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Container showTreeImage(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      width: MediaQuery.of(context).size.width * 0.5 - 16.0,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), //ขอบโค้ง
        image: DecorationImage(
          image: NetworkImage(
              '${MyConstant().domain}${treeModels[index].pathImage}'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<Null> confirmOrder(int index) async {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                treeModels[index].nameTree,
                style: MyStyle().mainH2Title,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 180,
                height: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: NetworkImage(
                            '${MyConstant().domain}${treeModels[index].pathImage}'),
                        fit: BoxFit.cover)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.add_circle,
                        size: 36,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          amount++;
                          // print('amount = $amount');
                        });
                      }),
                  Text(
                    amount.toString(),
                    style: MyStyle().mainTitle,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.remove_circle,
                        size: 36,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        if (amount > 1) {
                          setState(() {
                            amount--;
                          });
                        }
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 110,
                    child: RaisedButton(
                      color: MyStyle().primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () {
                        Navigator.pop(context);
                        //print('Order ${treeModels[index].nameTree} = $amount');

                        addOrderToCart(index);
                      },
                      child: Text(
                        'Order',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: 110,
                    child: RaisedButton(
                      color: MyStyle().primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> addOrderToCart(int index) async {
    String nameShop = userModel.nameShop;
    String idTree = treeModels[index].id;
    String nameTree = treeModels[index].nameTree;
    String price = treeModels[index].price;

    int priceInt = int.parse(price);
    int sumInt = priceInt = amount;

    lat2 = double.parse(userModel.lat);
    lng2 = double.parse(userModel.lng);
    double distance = MyAPI().calculateDistance(lat1, lng1, lat2, lng2);

    var myFormat = NumberFormat('##0.0#','en_US');
    String distanceString = myFormat.format(distance);

    int transport = MyAPI().calculateTransport(distance);

    print(
        'idShop = $idShop, nameShop = $nameShop,idTree = $idTree,nameTree = $nameTree,price = $price,amount = $amount,sum = $sumInt,distance = $distanceString,transport = $transport');
  }
}
