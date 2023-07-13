// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:great_silk_road_product_manager/UI/dataListTest.dart';
import 'package:great_silk_road_product_manager/UI/dataTableForOrder.dart';
import 'package:great_silk_road_product_manager/UI/secondTableOrder.dart';
import 'package:great_silk_road_product_manager/apiBYY/apiGetOrderProduct.dart';
import 'package:great_silk_road_product_manager/models/orderProductModel.dart';

import '../bloc/fetch_data_bloc.dart';

class IssueGoodsPage extends StatelessWidget {
  final List<OrderProductModel> orderList;
  const IssueGoodsPage({
    Key? key,
    required this.orderList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTableForOrder(products: orderList);
        // return BlocProvider(create: (context)=> FetchDataBloc(RepositoryProvider.of<ApiGetOrderProducts>(context))..add(LoadProductEvent()), child: BlocBuilder<FetchDataBloc, FetchDataState>(
        //     builder: (context, state) {
        //   if (state is FetchDataLoadingState) {
        //     return const Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   } else if (state is FetchDataLoadedState) {
        //     return DataTableForOrderBloc(products: state.products);
        //   }
        //   return Center(child: Text('No connection'));
        // }),);
  }
}
