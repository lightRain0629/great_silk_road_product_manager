// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:great_silk_road_product_manager/UI/mainPageWithDrawer.dart';
import 'package:great_silk_road_product_manager/apiBYY/apiApprovement.dart';
import 'package:great_silk_road_product_manager/models/orderProductModel.dart';
import 'package:great_silk_road_product_manager/testDataStorage/quantity.dart';

import '../testDataStorage/selectedProducts.dart';

class DataTableForOrder extends StatefulWidget {
  final bool isUpdated;
  final List<OrderProductModel> products;
  const DataTableForOrder({
    Key? key,
    required this.products,
    required this.isUpdated,
  }) : super(key: key);

  @override
  State<DataTableForOrder> createState() => _DataTableForOrderState();
}

class _DataTableForOrderState extends State<DataTableForOrder> {
  List<OrderProductModel> productsSearched = [];
  List<OrderProductModel> selectedProducts = [];
  TextEditingController searchController = TextEditingController();
  String _searchResult = '';
  // bool isAddings = false;
  // List<ProductModel> selectedProducts = [];
  // int? sortColumnIndex;
  // bool isAscending = false;
  @override
  void initState() {
    // TODO: implement initState
    productsSearched =widget.products;
  }

  // cutLastSymbols<String>(String date) {
  //   List dateList = date.toString().split('');
  //   List res = [];
  //   if (dateList.length == 4) {
  //     return res.toList().join('');
  //   } else {
  //     for (var i = 0; i < 10; i++) {
  //       res.add(dateList[i]);
  //     }
  //   }
  //   return res.toList().join('');
  // }

  @override
  Widget build(BuildContext context) {
    List<String> columns = [
      'Баркод',
      'Срок год.',
      'Товар',
      'Ед. изм.',
      'На выдачу',
      'Выдано'
    ];
    return Stack(
      children: [
        Column(
          children: [
            TextFormField(
              onChanged: (value) async {
                await Future.delayed(const Duration(milliseconds: 500));
                setState(() {
                  _searchResult = value;

                  productsSearched = widget.products
                      .where((product) =>
                          product.barcode.contains(_searchResult) ||
                          product.fullGoodName
                              .toString()
                              .toLowerCase()
                              .contains(_searchResult.toLowerCase()))
                      .toList();
                });
              },
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Поиск продуктов',
                // suffix: TextButton(
                //     onPressed: () {
                //       searchController.text = '';
                //       productsSearched = widget.products;
                //       setState(() {});
                //     },
                //     child: Text('Clear'))
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                    columns: getColums(columns),
                    rows: getRows(productsSearched)),
              ),
            ),
            Container(
              color: selectedProductsOut.length >= productsSearched.length &&
                      selectedProductsOut.length != 0
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  selectedProductsOut.length >= productsSearched.length &&
                          selectedProductsOut.length != 0
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: OutlinedButton(
                              onPressed: () {
                                if (widget.isUpdated) {
                                  ApiOrderApprovement().getApprovementList(
                                      productsSearched[0].id);
                                  selectedProductsOut.clear();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainPageEndless(
                                                isUpdated: true,
                                              )));
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainPageEndless(
                                                isUpdated: true,
                                              )));
                                }
                              },
                              child: Text(widget.isUpdated
                                  ? 'Отправить'
                                  : 'Сохранить и проверить')),
                        )
                      : Container(
                          width: 1,
                          height: 1,
                          color: Colors.transparent,
                        ),
                ],
              ),
            )
          ],
        ),
        // Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Container(
        //       color: selectedProductsOut.length >= productsSearched.length &&
        //               selectedProductsOut.length != 0
        //           ? Colors.grey[100]
        //           : Colors.transparent,
        //       child: Row(
        //         children: [
        //           selectedProductsOut.length >= productsSearched.length &&
        //                   selectedProductsOut.length != 0
        //               ? Container(
        //                   margin: EdgeInsets.all(5),
        //                   child: OutlinedButton(
        //                       onPressed: () {
        //                         if (widget.isUpdated) {
        //                           ApiOrderApprovement().getApprovementList(
        //                               productsSearched[0].id);
        //                           selectedProductsOut.clear();
        //                           Navigator.pushReplacement(
        //                               context,
        //                               MaterialPageRoute(
        //                                   builder: (context) => MainPageEndless(
        //                                         isUpdated: true,
        //                                       )));
        //                         } else {
        //                           Navigator.pushReplacement(
        //                               context,
        //                               MaterialPageRoute(
        //                                   builder: (context) => MainPageEndless(
        //                                         isUpdated: true,
        //                                       )));
        //                         }
        //                       },
        //                       child: Text(widget.isUpdated
        //                           ? 'Отправить'
        //                           : 'Сохранить и проверить')),
        //                 )
        //               : Container(
        //                   width: 1,
        //                   height: 1,
        //                   color: Colors.transparent,
        //                 ),
        //         ],
        //       ),
        //     )),
      ],
    );
  }

  List<DataColumn> getColums(List<String> columns) => columns
      .map((String column) => DataColumn(
              label: Flexible(
                  child: Text(
            column,
            style: TextStyle(fontWeight: FontWeight.bold),
          ))))
      .toList();

  List<DataRow> getRows(List<OrderProductModel> products) {
    return products.map((product) {
      final TextEditingController countController = TextEditingController();
      return DataRow(
        cells: [
          DataCell(Text(product.barcode.toString())),
          DataCell(Text(cutLastSymbols(product.goodExpireDate))),
          DataCell(Text(product.fullGoodName.toString())),
          DataCell(Text(product.unitName.toString())),
          DataCell(Container(
              alignment: Alignment.centerRight,
              child: Text(
                product.quantityToGive.toString(),
                textAlign: TextAlign.right,
              ))),
          DataCell(Container(
              alignment: Alignment.centerRight,
              child: TextFormField(
                initialValue: quantityList[product.goodId].toString() == 'null'
                    ? '0'
                    : quantityList[product.goodId].toString(),
                // initialValue: product.quantityToGive.toString() == 'null'
                //     ? '0'
                //     : product.quantityToGive.toString(),
                onFieldSubmitted: (value) {
                  setState(() {
                    quantityList
                        .addAll({product.goodId: int.parse(value.toString())});
                    setState(() {
                      final isChecked = product.quantityToGive == quantityList[product.goodId];

                      // final isChecked =
                      //     product.quantityToGive == product.quantityToGive;

                      isChecked
                          ? selectedProductsOut.add(product.goodId)
                          : selectedProductsOut.remove(product.goodId);
                    });
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: countController.text,
                    errorText:
                        (quantityList[product.goodId].toString() == 'null'
                                        ? 0
                                        : quantityList[product.goodId]) >
                                    product.quantityToGive ||
                                quantityList[product.goodId] == String
                            ? 'Ошибка'
                            : null),
              ))),
        ],
        selected: selectedProductsOut.contains(product.goodId),
        onSelectChanged: (isSelected) {
          setState(() {
            final isChecked = product.quantityToGive == quantityList[product.goodId];

            // final isChecked = product.quantityToGive == product.quantityToGive;

            isChecked
                ? selectedProductsOut.add(product.goodId)
                : selectedProductsOut.remove(product.goodId);
          });
        },
      );
    }).toList();
  }
}
