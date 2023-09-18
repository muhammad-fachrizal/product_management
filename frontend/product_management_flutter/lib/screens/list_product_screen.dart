import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:product_management_flutter/common_widget/product_card_widget.dart';
import 'package:product_management_flutter/data/product_api.dart';
import 'package:product_management_flutter/model/product.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  List<Product> listProduct = [];

  Future<List<Product>> getAllProducts() async {
    listProduct.clear();
    var response = await ProductApi.getAllProductsApi();
    var rb = response.body;
    var listJson = jsonDecode(rb) as List;

    if (response.statusCode == 200) {
      setState(
        () {
          listProduct = listJson.map((e) => Product.fromJson(e)).toList();
        },
      );
    }

    return listProduct;
  }

  @override
  void initState() {
    super.initState();
    getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Product Management'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: getAllProducts,
                child: MasonryGridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (screenWidth <= 600) ? 1 : 2,
                  ),
                  itemCount: listProduct.length,
                  itemBuilder: (context, index) {
                    return ProductCardWidget(
                      productModel: Product(
                          id: listProduct[index].id,
                          title: listProduct[index].title,
                          description: listProduct[index].description,
                          price: listProduct[index].price,
                          stock: listProduct[index].stock),
                    );
                  },
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/addProductScreen',
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
