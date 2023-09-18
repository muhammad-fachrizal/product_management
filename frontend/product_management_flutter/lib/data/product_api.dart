import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:product_management_flutter/model/product.dart';

class ProductApi {
  static Future getAllProductsApi() async {
    String link = "https://nestjs-product-management.up.railway.app";
    //String link = "http://localhost:3000/";
    return await http
        .get(Uri.parse(link), headers: {"Accept": "application/json"});
  }

  static Future updateProductApi(Product productModel) async {
    String link =
        "https://nestjs-product-management.up.railway.app/update/${productModel.id}";
    //String link = "http://localhost:3000/update/${productModel.id}";
    Map body = {
      "title": productModel.title,
      "description": productModel.description,
      "price": productModel.price,
      "stock": productModel.stock
    };
    return await http.patch(Uri.parse(link),
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
  }

  static Future addNewProductApi(
      String title, String description, num price, int stock) async {
    String link = "https://nestjs-product-management.up.railway.app/add";
    //String link = "http://localhost:3000/add";
    Map body = {
      "title": title,
      "description": description,
      "price": price,
      "stock": stock
    };
    return await http.post(Uri.parse(link),
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
  }

  static Future deleteProductApi(String id) async {
    String link = "https://nestjs-product-management.up.railway.app/delete/$id";
    //String link = "http://localhost:3000/delete/$id";
    return await http
        .delete(Uri.parse(link), headers: {"Accept": "application/json"});
  }
}
