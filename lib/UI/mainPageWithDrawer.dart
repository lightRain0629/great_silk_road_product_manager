import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:great_silk_road_product_manager/UI/returnOfGoodsPage.dart';
import 'package:great_silk_road_product_manager/models/orderProductModel.dart';
import 'package:great_silk_road_product_manager/testDataStorage/testProducts.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu_frame.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';

import '../apiBYY/apiGetOrderProduct.dart';
import '../bloc/fetch_data_bloc.dart';
import '../models/productModel.dart';
import 'homePage.dart';
import 'issueGoodsPage.dart';

const mainValueKey = ValueKey('Home');
const issueGoodsValueKey = ValueKey('Issue goods');
const returnOfGoodsValueKey = ValueKey('Return of goods');

final Map<Key, MenuItemContent> menuItems = {
  mainValueKey: MenuItemContent(
      menuItem:
          MenuItemDefinition('Основная', mainValueKey, iconData: Icons.home)),
  issueGoodsValueKey: MenuItemContent(
      menuItem: MenuItemDefinition('Выдача товаров', issueGoodsValueKey,
          iconData: Icons.add_task)),
  returnOfGoodsValueKey: MenuItemContent(
      menuItem: MenuItemDefinition('Возврат товаров', returnOfGoodsValueKey,
          iconData: Icons.production_quantity_limits)),
};

class MainPageEndless extends StatefulWidget {
  const MainPageEndless({super.key});

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

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<List<OrderProductModel>>(
        future: ApiGetOrderProducts().getOrderedProdcuts(),
      builder: (context, snapOrder){
        if (snapOrder.hasData) {
                return Builder(
          builder: (context) => Scaffold(
              appBar: AppBar(
                  scrolledUnderElevation: 0.0,
                  backgroundColor: Colors.grey[100],
                  leading: Builder(
                    builder: (iconButtonBuilderContext) => IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        state.toggle(iconButtonBuilderContext);
                        setState(() {});
                      },
                      tooltip: 'Toggle the menu',
                    ),
                  )),
              body: NavigationDrawerMenuFrame(
                menuBackgroundColor: Colors.grey[100],
                body: Builder(
                  builder: (c) {
                    if (state.selectedMenuKey == null) {
                      return HomePage();
                    } else if (state.selectedMenuKey == mainValueKey) {
                      return HomePage();
                    } else if (state.selectedMenuKey == issueGoodsValueKey) {
                      return IssueGoodsPage( orderList: snapOrder.data!,);
                    } else if (state.selectedMenuKey == returnOfGoodsValueKey) {
                      return ReturnOfGoodsPage();
                    } else {
                      return HomePage();
                    }
                  },
                ),
                menuBuilder: Builder(builder: getMenu),
                menuMode: state.menuMode(context),
              )));
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

  Widget getMenu(BuildContext context) =>
      Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        NavigationDrawerMenu(
            highlightColor: Theme.of(context).colorScheme.primaryContainer,
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
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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