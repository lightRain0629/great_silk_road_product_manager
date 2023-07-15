// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:great_silk_road_product_manager/UI/dataTableForReturns.dart';

import 'package:great_silk_road_product_manager/apiBYY/apiGetInvoices.dart';
import 'package:great_silk_road_product_manager/apiBYY/apiGetInvoicesId.dart';
import 'package:great_silk_road_product_manager/apiBYY/apiPostReturns.dart';
import 'package:great_silk_road_product_manager/testDataStorage/returnedQuantity.dart';

import '../models/getInvoicesModel.dart';
import 'mainPageWithDrawer.dart';

class ReturnOfGoodsPage extends StatefulWidget {
  final int invoice;
  const ReturnOfGoodsPage({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  State<ReturnOfGoodsPage> createState() => _ReturnOfGoodsPageState();
}

class _ReturnOfGoodsPageState extends State<ReturnOfGoodsPage> {
  //       @override
  // void dispose() {
  //   // TODO: implement dispose
  //   countController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.invoice != 0) {
      return FutureBuilder<List<GetInvoices>>(
          future: ApiGetInvoices().getInvoices(widget.invoice),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final products = snapshot.data!;
              final List<GetInvoices> editableProducts = products;
              final List<GetInvoices> editedProducts = [];
              final columns = [
                'Баркод',
                'Срок год.',
                'Товар',
                'Ед. изм.',
                'Количество',
                'Возвраты',
              ];
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                            child: dataTableInside(columns, products)),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      // color: Colors.grey[100],
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      // color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: OutlinedButton(
                                onPressed: () {
                                  List.generate(editableProducts.length,
                                      (index) {
                                    if (returnedQuantity[
                                                editableProducts[index].id +
                                                    widget.invoice]
                                            .toString() ==
                                        'null' || returnedQuantity[
                                                editableProducts[index].id +
                                                    widget.invoice]
                                            .toString() == '0' || returnedQuantity[
                                                editableProducts[index].id +
                                                    widget.invoice]  > editableProducts[index].quantity ) {
                                      // return editedProducts;
                                      print(' dont match');
                                    } else {
                                      return editedProducts
                                          .add(editableProducts[index]);
                                    }
                                  });
                                  if (editedProducts.isEmpty) {
                                    print('empty');
                                  } else {
                                    ApiPostReturns().postReturns(
                                        widget.invoice,
                                        List.generate(editedProducts.length,
                                            (index) {
                                          return {
                                            "id": editedProducts[index].id,
                                            "quantity": (returnedQuantity[
                                                            editedProducts[
                                                                        index]
                                                                    .id +
                                                                widget.invoice]
                                                        .toString() ==
                                                    'null'
                                                ? 0
                                                : returnedQuantity[
                                                    editedProducts[index].id +
                                                        widget.invoice]),
                                          };
                                        }));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainPageEndless()));
                                  }
                                  ;
                                },
                                child: Text('Отправить')),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    } else {
      return Center(
        child: Text('Выберите счет'),
      );
    }
  }

  Widget dataTableInside(List<String> columns, List<GetInvoices> products) {
    return DataTable(columns: getColums(columns), rows: getRows(products));
  }

  List<DataColumn> getColums(List<String> columns) => columns
      .map((String column) => DataColumn(
              // onSort: onSort,
              label: Flexible(
                  child: Text(
            column,
            style: TextStyle(fontWeight: FontWeight.bold),
          ))))
      .toList();

  List<DataRow> getRows(List<GetInvoices> products) {
    return products.map((product) {
      final initVal =
          (returnedQuantity[product.id + widget.invoice].toString() == 'null'
                      ? 0
                      : returnedQuantity[product.id + widget.invoice]) >
                  0
              ? returnedQuantity[product.id + widget.invoice].toString()
              : 0.toString();
      TextEditingController countController =
          TextEditingController(text: initVal);

      return DataRow(cells: [
        DataCell(Text(product.barcode.toString())),
        DataCell(Text(cutLastSymbols(product.expiredDate.toString()))),
        DataCell(Text(product.name.toString())),
        DataCell(Text(product.unitName)),
        DataCell(Container(
            alignment: Alignment.centerRight,
            child: Text(
              product.quantity.toString(),
              textAlign: TextAlign.right,
            ))),
        DataCell(Container(
            alignment: Alignment.centerRight,
            child: TextFormField(
              controller: countController,
              // initialValue: returnedQuantity[product.id + widget.invoice].toString() == 'null'
              //     ? '0'
              //     : returnedQuantity[product.id + widget.invoice ].toString(),
              // initialValue: initVal,

              onFieldSubmitted: (value) {
                setState(() {
                  returnedQuantity.addAll({
                    product.id + widget.invoice: int.parse(value.toString())
                  });
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  errorText: (returnedQuantity[product.id + widget.invoice]
                                          .toString() ==
                                      'null'
                                  ? 0
                                  : returnedQuantity[
                                      product.id + widget.invoice]) >
                              product.quantity ||
                          returnedQuantity[product.id + widget.invoice] ==
                              String
                      ? 'Ошибка'
                      : null),
            ))),
      ]);
    }).toList();
  }
}
