import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:great_silk_road_product_manager/UI/dataListTest.dart';
import 'package:great_silk_road_product_manager/UI/secondTableOrder.dart';
import 'package:great_silk_road_product_manager/apiBYY/apiApprovement.dart';
import 'package:great_silk_road_product_manager/apiBYY/apiGetOrderProduct.dart';
import 'package:great_silk_road_product_manager/apiBYY/testApi.dart';
import 'package:great_silk_road_product_manager/bloc/fetch_data_bloc.dart';
import 'package:great_silk_road_product_manager/models/product.dart';
import 'package:great_silk_road_product_manager/models/productModel.dart';
import 'package:great_silk_road_product_manager/storage/storage.dart';
import 'package:great_silk_road_product_manager/testDataStorage/emptyList.dart';
import 'package:great_silk_road_product_manager/testDataStorage/userTestDataStorage.dart';

import '../apiBYY/apiGetProduct.dart';
import 'dataTableByMyself.dart';

class HomePage extends StatefulWidget {
  // final List<ProductModel> productList;
  HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: TestApi().getProductTest(),
        builder: (BuildContext context, snap) {
          if (snap.hasData) {
            return DataTableBYY(products: snap.data!);
          } else {
            return Center(child: CircularProgressIndicator(),);
          } 
        });

  }
}
