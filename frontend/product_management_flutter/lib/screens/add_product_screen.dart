import 'package:flutter/material.dart';
import 'package:product_management_flutter/common_widget/form_product.dart';
import 'package:product_management_flutter/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  void initState() {
    super.initState();
    setFlag();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Add New Product'),
      ),
      body: FormProduct(
          productModel:
              Product(id: '', title: '', description: '', price: 0, stock: 0)),
    );
  }

  setFlag() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('isAdd', true);
    // SharedPrefLocal.setIsAddValue(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAdd', true);
  }
}
