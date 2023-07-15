import 'dart:convert';

import 'package:great_silk_road_product_manager/apiBYY/apiParams.dart';
import 'package:http/http.dart' as http;

import '../models/getInvoicesIdModel.dart';
import '../testDataStorage/userTestDataStorage.dart';

class ApiGetInvoicesId {
  Future<List<GetInvoicesId>>getInvoicesId() async {
    String endpoint = '/api/v1/temp/orders/invoices?warehouseId=35';
    final response =
        await http.get(Uri.parse(ApiParams().uri + endpoint), headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${userDataTest['token']}',
    });
    final body = jsonDecode(response.body);
    // print(body);
    return body.map<GetInvoicesId>(GetInvoicesId.fromJson).toList();
    // return body;
  }
}
