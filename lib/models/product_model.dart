import 'dart:convert';

class CatalogModel {
  static List<Item> items = [];
  Item getById(int id) =>
      // ignore: null_closures
      items.firstWhere((element) => element.id == id, orElse: null);
  Item getByPosition(int pos) => items[pos];
}

class Item {
  final id;
  final name;
  final bColor;
  final tColor;
  final image;
  final itemCount;
  final numItem;
  final show;

  Item({
    required this.tColor,
    required this.id,
    required this.name,
    required this.itemCount,
    required this.numItem,
    required this.show,
    required this.bColor,
    required this.image,
  });

  Item copyWith({
    required int id,
    required String name,
    required String bColor,
    required String tColor,
    required String image,
    required num itemCount,
    required num numItem,
    required bool show,
  }) {
    return Item(
        id: id,
        name: name,
        bColor: bColor,
        tColor: tColor,
        image: image,
        itemCount: itemCount,
        numItem: numItem,
        show: show);
  }

  Map<String, dynamic> toMap() {
    return {
      "TopCategoryId": id,
      "TopCategoryName": name,
      "Image": image,
      "BackgroundColor": bColor,
      "TextColor": tColor,
      "NumberItem": numItem,
      "ShowOnMenu": show,
      "ProductCount": itemCount,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map["TopCategoryId"],
      name: map["TopCategoryName"],
      image: map['Image'],
      bColor: map["BackgroundColor"],
      tColor: map["TextColor"],
      numItem: map["NumberItem"],
      show: map["ShowOnMenu"],
      itemCount: map["ProductCount"],
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Item(tColor: $tColor, id: $id, name: $name, itemCount: $itemCount, numItem: $numItem, show: $show, bColor: $bColor, image: $image)';
  }
}
