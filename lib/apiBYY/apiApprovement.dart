import 'dart:convert';

import 'package:great_silk_road_product_manager/apiBYY/apiParams.dart';
import 'package:great_silk_road_product_manager/models/approvementModel.dart';
import 'package:http/http.dart' as http;

import '../testDataStorage/userTestDataStorage.dart';

class ApiOrderApprovement {
  Future<List<OrderApprovementModel>> getApprovementList(int orderId) async {
    String endpoint = '/api/v1/temp/orders/approvement';
    final dataToSend = {"orderId": "$orderId"};
    final response = await http.post(
        Uri.parse(ApiParams().uri + endpoint),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${userDataTest['token']}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(dataToSend));
    final body = jsonDecode(response.body);
    // print(body);
    return body.map<OrderApprovementModel>(OrderApprovementModel.fromJson).toList();
  }
}
