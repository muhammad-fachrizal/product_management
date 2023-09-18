import 'package:flutter/material.dart';
import 'package:product_management_flutter/model/product.dart';
import 'package:product_management_flutter/screens/add_product_screen.dart';
import 'package:product_management_flutter/screens/detail_product_screen.dart';
import 'package:product_management_flutter/screens/list_product_screen.dart';
import 'package:product_management_flutter/theme_manager/color_schemes.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Management',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      initialRoute: '/listProductScreen',
      routes: {
        '/listProductScreen': (context) => const ListProductScreen(),
        '/addProductScreen': (context) => const AddProductScreen(),
        '/detailProductScreen': (context) => DetailProductScreen(
              productModel:
                  ModalRoute.of(context)?.settings.arguments as Product,
            ),
      },
    );
  }
}
