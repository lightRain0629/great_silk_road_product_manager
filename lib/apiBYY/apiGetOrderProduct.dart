import 'dart:convert';

import 'package:great_silk_road_product_manager/apiBYY/apiParams.dart';
import 'package:http/http.dart' as http;

import '../models/orderProductModel.dart';
import '../testDataStorage/userTestDataStorage.dart';

class ApiGetOrderProducts {
  Future<List<OrderProductModel>> getOrderedProdcuts() async {
    String endpoint = '/api/v1/temp/orders?warehouseId=35';
    final response = await http.get(
        Uri.parse(ApiParams().uri + endpoint),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${userDataTest['token']}',
        });
    final body = jsonDecode(response.body);
    // print(body);
    return body.map<OrderProductModel>(OrderProductModel.fromJson).toList();
    // return body;
  }
}
