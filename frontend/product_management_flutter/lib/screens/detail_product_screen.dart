import 'package:flutter/material.dart';
import 'package:product_management_flutter/common_widget/form_product.dart';
import 'package:product_management_flutter/data/product_api.dart';
import 'package:product_management_flutter/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key, required this.productModel});

  final Product productModel;

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
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
        title: const Text('Product Detail'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Product'),
                      content:
                          const Text('Do you want to delete this product?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'CANCEL');
                          },
                          child: const Text('CANCEL'),
                        ),
                        TextButton(
                          onPressed: () async {
                            var response = await ProductApi.deleteProductApi(
                                widget.productModel.id);
                            //check the context is mounted or not
                            if (!mounted) return;
                            if (response.statusCode == 200) {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                    content:
                                        Text('Product Deleted Successfully')));
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/listProductScreen', ((route) => false));
                            } else {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                    content: Text('Request Failed')));
                              Navigator.pop(context, 'OK');
                            }
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: FormProduct(productModel: widget.productModel),
    );
  }

  void setFlag() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('isAdd', false);
    //SharedPrefLocal.setIsAddValue(false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAdd', false);
  }
}
