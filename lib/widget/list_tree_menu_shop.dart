import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treeshop/model/tree_model.dart';
import 'package:treeshop/screens/add_tree_menu.dart';
import 'package:treeshop/screens/edit_tree_menu.dart';
import 'package:treeshop/utility/my_constant.dart';
import 'package:treeshop/utility/my_style.dart';

class ListTreeMentShop extends StatefulWidget {
  @override
  _ListTreeMentShopState createState() => _ListTreeMentShopState();
}

class _ListTreeMentShopState extends State<ListTreeMentShop> {
  bool loadStatus = true; // ยังโหลดไม่เสร็จ
  bool status = true; // มีข้อมูล
  List<TreeModel> treeModels = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readTreeMenu();
  }

  Future<Null> readTreeMenu() async {
    if (treeModels.length != 0) {
      treeModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idShop = preferences.getString('id');
    print('idShop = $idShop');

    String url =
        '${MyConstant().domain}/treeshop/getTreeWhereIdShop.php?isAdd=true&idShop=$idShop';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });

      if (value.toString() != 'null') {
        // print('value ==>> $value');

        var result = json.decode(value.data);
        // print('result ==>> $result');

        for (var map in result) {
          TreeModel treeModel = TreeModel.fromJson(map);
          setState(() {
            treeModels.add(treeModel);
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
    // print('res ==> $response');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        loadStatus ? MyStyle().showProgress() : showContent(),
        addMenuButton(),
      ],
    );
  }

  Widget showContent() {
    return status
        ? showListTree()
        : Center(
            child: Text('ไม่มีรายการต้นไม้'),
          );
  }

  Widget showListTree() => ListView.builder(
        itemCount: treeModels.length,
        itemBuilder: (context, index) => Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.4,
              child: Image.network(
                '${MyConstant().domain}${treeModels[index].pathImage}',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      treeModels[index].nameTree,
                      style: MyStyle().mainTitle,
                    ),
                    Text(
                      'ราคา ${treeModels[index].price} บาท',
                      style: MyStyle().mainH2Title,
                    ),
                    Text(
                      treeModels[index].detail,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => EditTreeMenu(
                                treeModel: treeModels[index],
                              ),
                            );
                            Navigator.push(context, route)
                                .then((value) => readTreeMenu());
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => deleteTree(treeModels[index]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Future<Null> deleteTree(TreeModel treeModel) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: MyStyle().showTitleH2('คุณต้องการลบมนู ${treeModel.nameTree} ?'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String url =
                      '${MyConstant().domain}/treeshop/deleteTreeWhereId.php?isAdd=true&id=${treeModel.id}';
                  await Dio().get(url).then(
                        (value) => readTreeMenu(),
                      );
                },
                child: Text('ยืนยัน'),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ยกเลิก'),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget addMenuButton() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => AddTreeMenu(),
                    );
                    Navigator.push(context, route)
                        .then((value) => readTreeMenu());
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      );
}
