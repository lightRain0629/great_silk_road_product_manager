import 'package:flutter/material.dart';
import 'package:great_silk_road_product_manager/apiBYY/apiGetInvoicesId.dart';
import 'package:great_silk_road_product_manager/testDataStorage/returnedQuantity.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu_frame.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:great_silk_road_product_manager/UI/returnOfGoodsPage.dart';
import 'package:great_silk_road_product_manager/models/orderProductModel.dart';
import '../apiBYY/apiGetOrderProduct.dart';
import '../models/getInvoicesIdModel.dart';
import 'homePage.dart';
import 'issueGoodsPage.dart';

cutLastSymbols<String>(String date) {
  List dateList = date.toString().split('');
  List res = [];
  if (dateList.length == 4) {
    return res.toList().join('');
  } else {
    for (var i = 0; i < 10; i++) {
      res.add(dateList[i]);
    }
  }
  return res.toList().join('');
}

const mainValueKey = ValueKey('Home');
const issueGoodsValueKey = ValueKey('Issue goods');
const returnOfGoodsValueKey = ValueKey('Return of goods');

final Map<Key, MenuItemContent> menuItems = {
  mainValueKey: MenuItemContent(
      menuItem:
          MenuItemDefinition('Основная', mainValueKey, iconData: Icons.home_outlined)),
  issueGoodsValueKey: MenuItemContent(
      menuItem: MenuItemDefinition('Выдача товаров', issueGoodsValueKey,
          iconData: Icons.add_task)),
  returnOfGoodsValueKey: MenuItemContent(
      menuItem: MenuItemDefinition('Возврат товаров', returnOfGoodsValueKey,
          iconData: Icons.production_quantity_limits)),
};

class MainPageEndless extends StatefulWidget {
  final bool isUpdated;
  MainPageEndless({
    Key? key,
    this.isUpdated = false,
  }) : super(key: key);

  @override
  State<MainPageEndless> createState() => _MainPageEndlessState();
}

final NavigationDrawerState state = NavigationDrawerState();

class _MainPageEndlessState extends State<MainPageEndless> {
  // final Map pagesMap = {
  //   mainValueKey: HomePage(),
  //   issueGoodsValueKey: IssueGoodsPage(),
  //   returnOfGoodsValueKey: ReturnOfGoodsPage(),
  // };
  String? values;
  int? invoiceId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderProductModel>>(
        future: ApiGetOrderProducts().getOrderedProdcuts(),
        builder: (context, snapOrder) {
          if (snapOrder.hasData) {
            return FutureBuilder<List<GetInvoicesId>>(
                future: ApiGetInvoicesId().getInvoicesId(),
                builder: (context, snapInvoiceId) {
                  if (snapInvoiceId.hasData) {
                    return Builder(
                        builder: (context) => Scaffold(
                            appBar: AppBar(
                                title: state.selectedMenuKey ==
                                        returnOfGoodsValueKey
                                    ? Container(
                                        color: Colors.transparent,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            iconSize: 30,
                                            elevation: 0,
                                            value: values,
                                            items: List.generate(
                                                snapInvoiceId.data!.length,
                                                (index) {
                                              final invoices =
                                                  snapInvoiceId.data![index];
                                              return DropdownMenuItem(
                                                  child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.65,
                                                      child: Row(
                                                        children: [
                                                          Text(cutLastSymbols(
                                                              invoices
                                                                  .invoiceDate)),
                                                          VerticalDivider(),
                                                          Text(invoices.code
                                                              .toString()),
                                                          VerticalDivider(),
                                                          Flexible(
                                                              child: Text(invoices
                                                                  .customerName
                                                                  .toString())),
                                                        ],
                                                      )),
                                                  value:
                                                      invoices.id.toString());
                                            }),
                                            // items: id.map(buildMenuItem).toList(),
                                            onChanged: (value) {
                                              this.values != null
                                                  ? showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                        content: Text(
                                                            ' Учтите данные не сохраняются при переходе.'),
                                                        title: Text(
                                                            'Хотите перейти на другой счет?'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: Text('Нет'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                returnedQuantity
                                                                    .clear();
                                                                print(
                                                                    returnedQuantity);
                                                                this.values =
                                                                    value;
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text('Да'),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : this.values = value;
                                              setState(() {});
                                              // setState(() {
                                              //   this.values = value;
                                              //   returnedQuantity.clear();
                                              // });
                                              // print(value.toString());
                                            },
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 1,
                                        height: 1,
                                        color: Colors.transparent,
                                      ),
                                actions: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainPageEndless(
                                                        isUpdated:
                                                            widget.isUpdated,
                                                      )));
                                        },
                                        child: Text('Обновить')),
                                  )
                                ],
                                scrolledUnderElevation: 0.0,
                                // backgroundColor: Colors.grey[100],
                                // backgroundColor: Colors.transparent,
                                // backgroundColor: Colors.transparent,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                leading: Builder(
                                  builder: (iconButtonBuilderContext) =>
                                      IconButton(
                                    icon: const Icon(Icons.menu),
                                    onPressed: () {
                                      state.toggle(iconButtonBuilderContext);
                                      setState(() {});
                                    },
                                    tooltip: 'Toggle the menu',
                                  ),
                                )),
                            drawer: NavigationDrawer(
                              // children: List.generate(1, (index) => Builder(builder: getMenu,)),
                              // menuBuilder: Builder(builder: getMenu),
                              // menuMode: state.menuMode(context),
                              children: [Builder(builder: getMenu)],
                            ),
                            body: NavigationDrawerMenuFrame(
                              // menuBackgroundColor: Colors.transparent,
                              menuBackgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              // menuBackgroundColor: Colors.grey[100],
                              body: Builder(
                                builder: (c) {
                                  if (state.selectedMenuKey == null) {
                                    return HomePage();
                                  } else if (state.selectedMenuKey ==
                                      mainValueKey) {
                                    return HomePage();
                                  } else if (state.selectedMenuKey ==
                                      issueGoodsValueKey) {
                                    return IssueGoodsPage(
                                      isUpdated: widget.isUpdated,
                                      orderList: snapOrder.data!,
                                    );
                                  } else if (state.selectedMenuKey ==
                                      returnOfGoodsValueKey) {
                                    return ReturnOfGoodsPage(
                                      invoice: this.values == null
                                          ? 0
                                          : int.parse(this.values!),
                                    );
                                  } else {
                                    return HomePage();
                                  }
                                },
                              ),
                              menuBuilder: Builder(builder: getMenu),
                              menuMode: state.menuMode(context),
                            )));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
    //       builder: (c) => Center(
    //           child: state.selectedMenuKey == null
    //               ? Center(child: Text("hello lets work today"),)
    //               : Icon(menuItems[state.selectedMenuKey]!
    //                   .menuItem!
    //                   .iconData))),
    //   menuBuilder: Builder(builder: getMenu),
    //   menuMode: state.menuMode(context),
    // )));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      child: Container(
          width: MediaQuery.of(context).size.width * 0.5, child: Text(item)),
      value: item.toString());

  Widget getMenu(BuildContext context) =>
      Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        NavigationDrawerMenu(
            highlightColor: Colors.white,
            // highlightColor: Theme.of(context).colorScheme.primaryContainer,
            onSelectionChanged: (c, key) {
              state.selectedMenuKey = key;
              state.closeDrawer(c);
              setState(() {});
            },
            menuItems: menuItems.values.toList(),
            selectedMenuKey: state.selectedMenuKey,
            itemPadding: const EdgeInsets.only(left: 5, right: 5),
            buildMenuButtonContent: (menuItemDefinition, isSelected,
                    buildContentContext) =>
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(menuItemDefinition.iconData,
                      color: isSelected ? Colors.black : Colors.black),
                  if (state.menuMode(context) != MenuMode.Thin)
                    const SizedBox(
                      width: 10,
                    ),
                  if (state.menuMode(context) != MenuMode.Thin)
                    Text(menuItemDefinition.text,
                        style: TextStyle(
                            color: isSelected ? Colors.black : Colors.black))
                ]))
      ]);
}





// => state.selectedMenuKey == null
//                       ? pagesMap[HomePage()]
//                       : pagesMap[state.selectedMenuKey]

