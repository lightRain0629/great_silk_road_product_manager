import 'dart:convert';
import 'package:great_silk_road_product_manager/apiBYY/apiParams.dart';
import 'package:http/http.dart' as http;
import '../testDataStorage/userTestDataStorage.dart';

class ApiPostReturns {
  Future<dynamic> postReturns (int invoiceId, List products) async {
    final dataToSend = {
      "invoiceId" : invoiceId,
      "warehouseId" : 35,
      "goods" : products
    };
    print(dataToSend);
    String endpoint = '/api/v1/temp/orders/return';
    final response = await http.post(Uri.parse(ApiParams().uri + endpoint),headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${userDataTest['token']}',
          'Content-Type': 'application/json',
        }, body: jsonEncode(dataToSend));
        final body = jsonDecode(response.body);
        print(body);
        return body;
  }
}