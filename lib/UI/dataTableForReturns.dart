import 'package:flutter/material.dart';

import '../models/getInvoicesModel.dart';
import 'mainPageWithDrawer.dart';

class DataTableForReturns extends StatefulWidget {
  final List<GetInvoices> products;
  DataTableForReturns({super.key, required this.products});

  @override
  State<DataTableForReturns> createState() => _DataTableForReturnsState();
}

class _DataTableForReturnsState extends State<DataTableForReturns> {
  List<GetInvoices> productsSearched = [];
  TextEditingController searchController = TextEditingController();
  String _searchResult = '';

  @override
  void initState() {
    // TODO: implement initState
    productsSearched = widget.products;
  }

  @override
  Widget build(BuildContext context) {
    final columns = [
      'Баркод',
      'Срок год.',
      'Товар',
      'Ед. изм.',
      'Количество'
    ];
    return Column(
      children: [
        TextField(
          onChanged: (value) async {
            await Future.delayed(const Duration(microseconds: 300));
            setState(() {
              _searchResult = value;
              productsSearched = widget.products
                  .where((product) =>
                      product.barcode.contains(_searchResult) ||
                      product.name
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
              suffix: TextButton(
                  onPressed: () {
                    searchController.text = '';
                    productsSearched = widget.products;
                    setState(() {});
                  },
                  child: Text('Clear'))),
        ),
        Expanded(
          child: SingleChildScrollView(
              child: dataTableInside(columns, productsSearched)),
        ),
      ],
    );
  }

  Widget dataTableInside(List<String> columns, dynamic productsSearched) {
    if (productsSearched == []) {
      return Center(
        child: Text('Товара нет'),
      );
    } else {
      return DataTable(
          columns: getColums(columns),
          rows: getRows(productsSearched));
    }
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
      return DataRow(
          cells: [
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
          ]
          );
    }).toList();
  }
}
