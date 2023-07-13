import 'dart:convert';

import 'package:great_silk_road_product_manager/apiBYY/apiParams.dart';
import 'package:great_silk_road_product_manager/testDataStorage/userTestDataStorage.dart';
import 'package:http/http.dart' as http;

import '../models/productModel.dart';

class ApiGetProducts {
  Future<List<ProductModel>> getProducts = getProductsList();

  static Future<List<ProductModel>> getProductsList() async {
    String endpoint = '/api/v1/temp/goods?warehouseId=1';
    final response =
        await http.get(Uri.parse(ApiParams().uri + endpoint), headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${userDataTest['token']}',
    });
    final body = await jsonDecode(response.body);
    print(body);
    return await body.map<ProductModel>(ProductModel.fromJson).toList();
  }
}
