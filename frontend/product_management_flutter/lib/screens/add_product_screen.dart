import 'package:flutter/material.dart';
import 'package:product_management_flutter/common_widget/form_product.dart';
import 'package:product_management_flutter/model/product.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Add New Product'),
      ),
      body: SafeArea(
        child: FormProduct(
          productModel:
              Product(id: '', title: '', description: '', price: 0, stock: 0),
          flgIsAdd: true,
        ),
      ),
    );
  }
}
