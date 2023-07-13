import 'package:flutter/material.dart';
import 'package:great_silk_road_product_manager/UI/loginPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'UI/mainPageWithDrawer.dart';
import 'apiBYY/apiGetOrderProduct.dart';
import 'colorScheme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      // darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: RepositoryProvider(
        create: (context) => ApiGetOrderProducts(),
        child: LoginPage(),
      ),
    );
  }
}
