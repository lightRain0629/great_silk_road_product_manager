// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:great_silk_road_product_manager/models/orderProductModel.dart';

import '../testDataStorage/quantity.dart';

class DataTableForOrderBloc extends StatefulWidget {
  final List<OrderProductModel> products;
  const DataTableForOrderBloc({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<DataTableForOrderBloc> createState() => _DataTableForOrderBlocState();
}

class _DataTableForOrderBlocState extends State<DataTableForOrderBloc> {
  dynamic productsSearched = [];
  List selectedProducts = [];
  TextEditingController searchController = TextEditingController();
  String _searchResult = '';
  bool isAddings = false;
  // List<ProductModel> selectedProducts = [];
  // int? sortColumnIndex;
  // bool isAscending = false;
  @override
  void initState() {
    // TODO: implement initState
    productsSearched = widget.products;
  }

   

  cutLastSymbols<String>(String date) {
    List dateList = date.toString().split('');
    List res = [];
    for (var i = 0; i < 10; i++) {
      res.add(dateList[i]);
    }
    return res.toList().join('');
  }

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
    return Column(
      children: [
        TextField(
          onChanged: (value) {
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
            child: DataTable(
                columns: getColums(columns), rows: getRows(productsSearched)),
          ),
        ),
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
        selected: selectedProducts.contains(product),
        onSelectChanged: (isSelected){
          setState(() {
             isAddings = isSelected != null && isSelected;

            isAddings ? selectedProducts.add(product) : selectedProducts.remove(product);
          });
        },
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
              initialValue: quantityList[product.goodId].toString() == '0'? '0' : quantityList[product.goodId].toString() ,
              // controller: countController,
              onSaved: (value){
                quantityList[product.goodId] = int.parse(value.toString());
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: countController.text),
            ))),
      ]);
    }).toList();
  }
}
