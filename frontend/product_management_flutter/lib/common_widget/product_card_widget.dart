import 'package:flutter/material.dart';
import 'package:product_management_flutter/model/product.dart';
import 'package:intl/intl.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key, required this.productModel});

  final Product productModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detailProductScreen',
          arguments: Product(
            id: productModel.id,
            title: productModel.title,
            description: productModel.description,
            price: productModel.price,
            stock: productModel.stock,
          ),
        );
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.blueGrey, width: 2.0),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 6,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                productModel.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                maxLines: 2,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                    ).format(productModel.price),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    'Stock: ${productModel.stock.toString()}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                productModel.description,
                style: const TextStyle(
                  fontSize: 14,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
    );
  }
}
