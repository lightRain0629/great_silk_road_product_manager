import 'package:flutter/material.dart';
import 'package:great_silk_road_product_manager/models/product.dart';

import '../models/productModel.dart';

class DataTableBYY extends StatefulWidget {
  final List<dynamic> products;
  const DataTableBYY({super.key, required this.products});

  @override
  State<DataTableBYY> createState() => _DataTableBYYState();
}

class _DataTableBYYState extends State<DataTableBYY> {
  cutLastSymbols<String>(String date) {
    
    List dateList = date.toString().split('');
    dynamic res = [];
    if (dateList.length == 4) {
      res = [];
    } else {
      for (var i = 0; i < 10; i++) {
        res.add(dateList[i]);
      }
    }
    return res.toList().join('');
  }

  dynamic productsSearched = [];
  TextEditingController searchController = TextEditingController();
  String _searchResult = '';

  // List<ProductModel> selectedProducts = [];
  // int? sortColumnIndex;
  // bool isAscending = false;
  @override
  void initState() {
    // TODO: implement initState
    productsSearched = widget.products;
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController searchController = TextEditingController();
    final columns = [
      'Бренд',
      'Баркод',
      'Продукт',
      'Срок год.',
      'Ед. изм.',
      'Количество'
    ];
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            setState(() {
              _searchResult = value;
              productsSearched = widget.products
                  .where((product) =>
                      product['barcode'].contains(_searchResult) ||
                      product['brandName']
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
          // sortAscending: isAscending,
          // sortColumnIndex: sortColumnIndex,
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

  List<DataRow> getRows(List<dynamic> products) {
    return products.map((product) {
      // final cells = [
      //   product['brandName'],
      //   product['barcode'],
      //   product['name'],
      //   product['expireDate'],
      //   product['unitName'],
      //   product['quantity']
      // ];
      return DataRow(
          // selected: selectedProducts.contains(product),
          // onSelectChanged: (isSelected) => setState(() {
          //       final isAdding = isSelected != null && isSelected;
          //       isAdding
          //           ? selectedProducts.add(product)
          //           : selectedProducts.remove(product);
          //     }),
          cells: [
            DataCell(Text(product['brandName'].toString())),
            DataCell(Text(product['barcode'].toString())),
            DataCell(Text(product['name'].toString())),
            DataCell(Text(cutLastSymbols(product['expireDate'].toString()))),
            DataCell(Text(product['unitName'].toString())),
            DataCell(Container(
                alignment: Alignment.centerRight,
                child: Text(
                  product['quantity'].toString(),
                  textAlign: TextAlign.right,
                ))),
          ]
          // cells: getCells(cells)
          );
    }).toList();
  }

  // List<DataCell> getCells(List<dynamic> cells) => cells
  //     .map((data) => DataCell(
  //           Container(
  //               alignment:
  //                   data == num ? Alignment.centerRight : Alignment.centerLeft,
  //               child: Text(
  //                 '$data',
  //                 textAlign: data == num ? TextAlign.right : TextAlign.left,
  //               )),
  //         ))
  //     .toList();

  // void onSort(int columnIndex, bool ascending) {
  //   if (columnIndex == 0) {
  //     widget.products.sort((product1, product2) =>
  //         compareString(ascending, product1.brandName, product2.brandName));
  //   }

  //   setState(() {
  //     this.sortColumnIndex = columnIndex;
  //     this.isAscending = ascending;
  //   });
  // }

  // int compareString(bool ascending, String value1, String value2) =>
  //     ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  // void searchProduct (String query){
  //   final suggestions = widget.products.where((product){});
  // }
}
