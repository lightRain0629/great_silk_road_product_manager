import 'dart:convert';

import 'package:great_silk_road_product_manager/apiBYY/apiParams.dart';
import 'package:http/http.dart' as http;

import '../models/getInvoicesModel.dart';
import '../testDataStorage/userTestDataStorage.dart';

class ApiGetInvoices {
  Future<List<GetInvoices>> getInvoices(int invoiceId) async {
    String endpoint = '/api/v1/temp/orders/invoices/$invoiceId';
    final response =
        await http.get(Uri.parse(ApiParams().uri + endpoint), headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${userDataTest['token']}',
    });
    final body = jsonDecode(response.body);
    // print(body);
    return body.map<GetInvoices>(GetInvoices.fromJson).toList();
  }
}
