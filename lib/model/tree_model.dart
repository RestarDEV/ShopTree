class TreeModel {
  String id;
  String idShop;
  String nameTree;
  String pathImage;
  String price;
  String detail;

  TreeModel(
      {this.id,
      this.idShop,
      this.nameTree,
      this.pathImage,
      this.price,
      this.detail});

  TreeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idShop = json['idShop'];
    nameTree = json['NameTree'];
    pathImage = json['PathImage'];
    price = json['Price'];
    detail = json['Detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idShop'] = this.idShop;
    data['NameTree'] = this.nameTree;
    data['PathImage'] = this.pathImage;
    data['Price'] = this.price;
    data['Detail'] = this.detail;
    return data;
  }
}
