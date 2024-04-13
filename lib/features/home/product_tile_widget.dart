import 'package:blocsample/features/home/bloc/home_bloc.dart';
import 'package:blocsample/features/models/product_model.dart';
import 'package:flutter/material.dart';

import 'bloc/home_event.dart';

class ProductTileWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  final ProductModel productModel;
  const ProductTileWidget(
      {super.key, required this.productModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.purple[100],
        border: Border.all(color: Colors.red, width: 2.0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(productModel.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    productModel.model,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Rs. ' + productModel.price.toString(),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      homeBloc
                          .add(CartBtnClkEvent(clickedProduct: productModel));
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(
                          WishlistBtnClkEvent(clickedProduct: productModel));
                    },
                    icon: Icon(Icons.favorite_border),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
