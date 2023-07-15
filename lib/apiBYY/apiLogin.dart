import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:great_silk_road_product_manager/apiBYY/apiGetProduct.dart';
import 'package:great_silk_road_product_manager/storage/storage.dart';
import 'package:great_silk_road_product_manager/testDataStorage/userTestDataStorage.dart';
import 'package:http/http.dart' as http;
import 'apiParams.dart';
import '../UI/mainPageWithDrawer.dart';

class ApiLogin {
  Future<dynamic> onLogin(Map data, BuildContext context) async {
    String endpoint = '/api/v1/temp/auth';
    try {
      var response = await http.post(Uri.parse(ApiParams().uri + endpoint),
          body: jsonEncode(data),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          });
      if (await response.statusCode == 200) {
        var body = jsonDecode(response.body);
        userDataTest['token'] = body['token'];
        UsersAuthStorage.setToken(body['token']);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MainPageEndless()));
        return body;
      } else if (response.statusCode == 400) {
        print(400);
        return 400;
      } else if (response.statusCode == 401) {
        print(401);
        return 401;
      } else if (response.statusCode == 429) {
        print(429);
        return 429;
      } else if (response.statusCode == 500) {
        // print(500);
        return 500;
      } else {
        print(response.body);
        print('write');
      }
    } catch (e) {
      return Exception(e.toString());
    }
  }
}
