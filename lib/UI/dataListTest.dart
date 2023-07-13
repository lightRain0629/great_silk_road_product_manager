import 'package:flutter/material.dart';
import 'package:great_silk_road_product_manager/models/product.dart';

import '../models/productModel.dart';

class DataTestWidget extends StatelessWidget {
  final List<dynamic> products;
  const DataTestWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context,index)=> ListTile(
      title: Text( products[index]['fullGoodName'].toString()),
      trailing: Text(products[index]['quantityToGive'].toString()),
    ));
  }
}