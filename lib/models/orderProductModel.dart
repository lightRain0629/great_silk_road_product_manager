// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:great_silk_road_product_manager/testDataStorage/quantity.dart';

class OrderProductModel {
  int id;
  int goodId;
  String goodExpireDate;
  String barcode;
  String fullGoodName;
  String unitName;
  int quantityToGive;
  // bool isChecked;

  OrderProductModel({
    required this.id,
    required this.goodId,
    required this.goodExpireDate,
    required this.barcode,
    required this.fullGoodName,
    required this.unitName,
    required this.quantityToGive,
    // required this.isChecked,
  });

   static OrderProductModel fromJson(json) => OrderProductModel(
      id: json['id'] ?? 'id',
      goodId: json['goodId'] ?? 'goodId',
      goodExpireDate: json['goodExpireDate'] ?? 'date',
      barcode: json['barcode'] ?? 'barcode',
      fullGoodName: json['fullGoodName'] ?? 'fullGoodName',
      unitName: json['unitName'] ?? 'unit' ,
      quantityToGive: json['quantityToGive'] ?? 1,
      // isChecked: json['quantityToGive'] == quantityList[]
      );
}
