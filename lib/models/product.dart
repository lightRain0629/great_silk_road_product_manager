// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final int id;
  final String name;
  final String groupId;
  final int typeId;
  final String typeName;
  final int brandId;
  final String brandName;
  final String barcode;
  final dynamic expireDate;
  final String fullGoodName;
  final int unitId;
  final String unitName;
  final num quantity;
  final String result;
  final String forSale;

  const Product({
    required this.id,
    required this.name,
    required this.groupId,
    required this.typeId,
    required this.typeName,
    required this.brandId,
    required this.brandName,
    required this.barcode,
    required this.expireDate,
    required this.fullGoodName,
    required this.unitId,
    required this.unitName,
    required this.quantity,
    required this.result,
    required this.forSale,
  });

  static Product fromJson(json) => Product(
      id: json['id'],
      name: json['name'],
      groupId: json['groupId'],
      typeId: json['typeId'],
      typeName: json['typeName'],
      brandId: json['brandId'],
      brandName: json['brandName'],
      barcode: json['barcode'],
      expireDate: json['expireDate'],
      // expireDate: DateFormat(json['expireDate'].parse(savedDateString)),
      fullGoodName: json['fullGoodName'],
      unitId: json['unitId'],
      unitName: json['unitName'],
      quantity: json['quantity'],
      result: json['result'],
      forSale: json['forSale']);
}


// DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(savedDateString);