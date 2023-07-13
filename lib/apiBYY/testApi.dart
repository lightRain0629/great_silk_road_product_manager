import 'dart:convert';

import 'package:great_silk_road_product_manager/apiBYY/apiParams.dart';
import 'package:great_silk_road_product_manager/models/product.dart';
import 'package:great_silk_road_product_manager/models/productModel.dart';
import 'package:http/http.dart' as http;

import '../testDataStorage/userTestDataStorage.dart';

class TestApi {
   Future<dynamic> getProductTest() async {
    String endpoint = '/api/v1/temp/goods?warehouseId=35';

    final response =
        await http.get(Uri.parse(ApiParams().uri + endpoint), headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${userDataTest['token']}',
    });
    final body = await jsonDecode(response.body);
    // final res = body.map<Product>(Product.fromJson).toList();
    // print(res);
    return body;
    // return body.map<Product>(Product.fromJson).toList();
  }
}
