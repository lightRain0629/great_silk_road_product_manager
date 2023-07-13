class ProductModel {
  final int id;
  final String name;
  final int groupId;
  final String goodName;
  final int typeId;
  final String typeName;
  final int brandId;
  final String brandName;
  final String barcode;
  final String expireDate;
  final String fullGoodName;
  final int unitId;
  final String unitName;
  final int quantity;
  final String result;
  final String forSale;

  const ProductModel({
    required this.id,
    required this.name,
    required this.groupId,
    required this.goodName,
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

  static ProductModel fromJson(json) => ProductModel(
      id: json['id'],
      name: json['name'],
      groupId: json['groupId'],
      goodName: json['goodName'],
      typeId: json['typeId'],
      typeName: json['typeName'],
      brandId: json['brandId'],
      brandName: json['brandName'],
      barcode: json['barcode'],
      expireDate: json['expireDate'],
      fullGoodName: json['fullGoodName'],
      unitId: json['unitId'],
      unitName: json['unitName'],
      quantity: json['quantity'],
      result: json['result'],
      forSale: json['forSale']);
}
