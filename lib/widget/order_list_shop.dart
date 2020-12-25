import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treeshop/model/order_model.dart';
import 'package:treeshop/utility/my_api.dart';
import 'package:treeshop/utility/my_constant.dart';
import 'package:treeshop/utility/my_style.dart';

class OrderListShop extends StatefulWidget {
  @override
  _OrderListShopState createState() => _OrderListShopState();
}

class _OrderListShopState extends State<OrderListShop> {
  String idShop;
  List<OrderModel> orderModels = List();
  List<List<String>> listNameTrees = List();
  List<List<String>> listPrices = List();
  List<List<String>> listAmounts = List();
  List<List<String>> listSums = List();
  List<int> totals = List();

  @override
  void initState() {
    super.initState();
    findidShopAndReadOrder();
  }

  Future<Null> findidShopAndReadOrder() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idShop = preferences.getString(MyConstant().keyId);
    print('idShop = $idShop');

    String path =
        '${MyConstant().domain}/treeshop/getOrderWhereIdShop.php?isAdd=true&idShop=$idShop';
    await Dio().get(path).then((value) {
      // print('value ==>> $value');
      var result = json.decode(value.data);
      // print('result ==>> $result');
      for (var item in result) {
        OrderModel model = OrderModel.fromJson(item);
        // print('orderDateTime = ${model.orderDateTime}');

        List<String> nameTrees = MyAPI().createStringArray(model.nameTree);
        List<String> prices = MyAPI().createStringArray(model.price);
        List<String> amounts = MyAPI().createStringArray(model.amount);
        List<String> sums = MyAPI().createStringArray(model.sum);

        int total = 0;
        for (var item in sums) {
          total = total + int.parse(item);
        }

        setState(() {
          orderModels.add(model);
          listNameTrees.add(nameTrees);
          listPrices.add(prices);
          listAmounts.add(amounts);
          listSums.add(sums);
          totals.add(total);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orderModels.length == 0
          ? MyStyle().showProgress()
          : ListView.builder(
              itemCount: orderModels.length,
              itemBuilder: (context, index) => Card(
                color: index % 2 == 0
                    ? Colors.green.shade100
                    : Colors.green.shade400,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyStyle().showTitleH2(orderModels[index].nameUser),
                      MyStyle().showTitleH3(orderModels[index].orderDateTime),
                      buildTitle(),
                      ListView.builder(
                        itemCount: listNameTrees[index].length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (contex, index2) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(listNameTrees[index][index2]),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(listPrices[index][index2]),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(listAmounts[index][index2]),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(listSums[index][index2]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MyStyle().showTitleH2('Total :'),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: MyStyle()
                                .showTitleH3Red(totals[index].toString()),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RaisedButton.icon(
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () {},
                              icon: Icon(Icons.cancel, color: Colors.white),
                              label: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              )),
                          RaisedButton.icon(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () {},
                              icon: Icon(Icons.developer_board,
                                  color: Colors.white),
                              label: Text(
                                'Arrangs trees',
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Container buildTitle() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.green.shade700),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text('Name Tree'),
          ),
          Expanded(
            flex: 1,
            child: Text('Price'),
          ),
          Expanded(
            flex: 1,
            child: Text('Amount'),
          ),
          Expanded(
            flex: 1,
            child: Text('Sum'),
          ),
        ],
      ),
    );
  }
}
