import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_management_flutter/data/product_api.dart';
import 'package:product_management_flutter/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormProduct extends StatefulWidget {
  const FormProduct({super.key, required this.productModel});

  final Product productModel;

  @override
  State<FormProduct> createState() => _FormProductState();
}

class _FormProductState extends State<FormProduct> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  String _title = '';
  String _description = '';
  num _price = 0;
  int _stock = 0;
  bool flgPriceIsNan = false;
  bool flgStockIsNan = false;
  //String btnText = '';
  //bool? isAdd;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.productModel.title;
    _descriptionController.text = widget.productModel.description;
    _priceController.text = widget.productModel.price.toString();
    _stockController.text = widget.productModel.stock.toString();
    //checkFlag();
  }

  @override
  Widget build(BuildContext context) {
    //print('isAdd value at the start of build: $isAdd');
    return FutureBuilder(
        future: checkFlag(),
        builder: (context, snapshot) {
          print('isAdd value inside future builder: ${snapshot.data}');
          if (snapshot.data == true) {
            //setState(() {
            _priceController.text = '';
            _stockController.text = '';
            //});
          }
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: _titleController,
                      minLines: 1,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey, width: 20.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: _priceController,
                      minLines: 1,
                      maxLines: 2,
                      keyboardType: TextInputType.number,
                      //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey, width: 20.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: _stockController,
                      minLines: 1,
                      maxLines: 2,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Stock',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey, width: 20.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey, width: 20.0),
                          ),
                        ),
                        controller: _descriptionController,
                        maxLines: 999,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: double.infinity,
                      child: FloatingActionButton(
                        onPressed: () async {
                          _title = _titleController.text;
                          _description = _descriptionController.text;
                          _price = (_priceController.text.toString().isEmpty ||
                                  (num.tryParse(_priceController.text)) == null)
                              ? 0
                              : num.parse(_priceController.text);
                          _stock = (_stockController.text.toString().isEmpty ||
                                  (int.tryParse(_stockController.text)) == null)
                              ? 0
                              : int.parse(_stockController.text);
                          flgPriceIsNan =
                              (num.tryParse(_priceController.text)) == null;
                          flgStockIsNan =
                              (int.tryParse(_stockController.text)) == null;
                          if (_title.trim().isEmpty ||
                              _description.trim().isEmpty ||
                              _priceController.text.toString().trim().isEmpty ||
                              _stockController.text.toString().trim().isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Empty Field'),
                                  content:
                                      const Text('All field must be filled'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (flgPriceIsNan ||
                              _price.isNegative ||
                              flgStockIsNan ||
                              _stock.isNegative) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Price or Stock Field'),
                                  content: const Text(
                                      'Price or Stock value is not a valid number'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            print('isAdd value: ${snapshot.data}');
                            var response = (snapshot.data == true)
                                //print('isAdd value: $isAdd');
                                //var response = (isAdd!)
                                ? await ProductApi.addNewProductApi(
                                    _title, _description, _price, _stock)
                                : await ProductApi.updateProductApi(Product(
                                    id: widget.productModel.id,
                                    title: _title,
                                    description: _description,
                                    price: _price,
                                    stock: _stock));
                            //check the context is mounted or not
                            if (!mounted) return;
                            if (response.statusCode == 200 ||
                                response.statusCode == 201) {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: (snapshot.data == true)
                                        //content: (isAdd!)
                                        ? const Text(
                                            'New Product Added Successfully')
                                        : const Text(
                                            'Product Updated Successfully'),
                                  ),
                                );
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/listProductScreen',
                                ((route) => false),
                              );
                            } else {
                              print('body: $_title, $_description, $_price,');
                              print('response: ${response.statusCode}');
                              print('statusCode: ${response.statusCode}');
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(
                                    content: Text('Request Failed'),
                                  ),
                                );
                              Navigator.pop(context, 'OK');
                            }
                          }
                        },
                        child: Text(
                          (snapshot.data == true) ? 'Add' : 'Update',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<bool?> checkFlag() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAdd');
    // if (prefs.getBool('isAdd')!) {
    //   _priceController.text = '';
    //   _stockController.text = '';
    // }

    // bool value = await SharedPrefLocal.getIsAddValue();
    // setState(() {
    //   isAdd = value;
    // });
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   isAdd = prefs.getBool('isAdd');
    // });
  }

  // checkFlag() async {
  //   // final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // return prefs.getBool('isAdd');
  //   // bool value = await SharedPrefLocal.getIsAddValue();
  //   // setState(() {
  //   //   isAdd = value;
  //   // });
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     isAdd = prefs.getBool('isAdd');
  //   });
  // }
}
