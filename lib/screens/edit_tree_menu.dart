import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treeshop/model/tree_model.dart';
import 'package:treeshop/utility/my_constant.dart';
import 'package:treeshop/utility/normal_dialog.dart';

class EditTreeMenu extends StatefulWidget {
  final TreeModel treeModel;
  EditTreeMenu({Key key, this.treeModel}) : super(key: key);

  @override
  _EditTreeMenuState createState() => _EditTreeMenuState();
}

class _EditTreeMenuState extends State<EditTreeMenu> {
  TreeModel treeModel;
  File file;
  String name, price, detail, pathImage;

  @override
  void initState() {
    super.initState();
    treeModel = widget.treeModel;
    name = treeModel.nameTree;
    price = treeModel.price;
    detail = treeModel.detail;
    pathImage = treeModel.pathImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: uploadButton(),
      appBar: AppBar(
        title: Text('ปรับปรุง เมนู ${treeModel.nameTree}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            nameTree(),
            groupImage(),
            priceTree(),
            detailTree(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton uploadButton() {
    return FloatingActionButton(
      onPressed: () {
        if (name.isEmpty || price.isEmpty || detail.isEmpty) {
          normalDialog(context, 'กรุณากรอกให้ครบ ทุกช่องคะ');
        } else {
          confirmEdit();
        }
      },
      child: Icon(Icons.cloud_upload),
    );
  }

  Future<Null> confirmEdit() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการจะ เปลี่ยนแปลง เมนูต้นไม้ จริงๆ นะ ?'),
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  editValueOnMySQL();
                },
                icon: Icon(Icons.check, color: Colors.green,),
                label: Text('เปลี่ยนแปลง'),
              ),
              FlatButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.clear, color: Colors.red,),
                label: Text('ไม่เปลี่ยนแปลง'),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<Null> editValueOnMySQL() async {

    String id = treeModel.id;
    String url = '${MyConstant().domain}/treeshop/editTreeWhereId.php?isAdd=true&id=$id&NameTree=$name&PathImage=$pathImage&Price=$price&Detail=$detail';
    await Dio().get(url).then((value){
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'กรุณาลองใหม่อีกครั้ง');
      }
    });

  }

  Widget groupImage() => Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () => chooseImage(ImageSource.camera)),
          Container(
            padding: EdgeInsets.all(16.0),
            width: 250.0,
            height: 250,
            child: file == null
                ? Image.network(
                    '${MyConstant().domain}${treeModel.pathImage}',
                    fit: BoxFit.cover,
                  )
                : Image.file(file),
          ),
          IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () => chooseImage(ImageSource.gallery)),
        ],
      );

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );
      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Widget nameTree() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => name = value.trim(),
              initialValue: name,
              decoration: InputDecoration(
                labelText: 'ชื่อ เมนู ต้นไม้',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget priceTree() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => price = value.trim(),
              keyboardType: TextInputType.number,
              initialValue: price,
              decoration: InputDecoration(
                labelText: 'ราคา ต้นไม้',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget detailTree() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => detail = value.trim(),
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              initialValue: detail,
              decoration: InputDecoration(
                labelText: 'รายละเอียด ต้นไม้',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
}
