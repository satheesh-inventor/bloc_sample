import 'package:blocsample/features/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class WishlistBtnClkEvent extends HomeEvent {
  final ProductModel clickedProduct;

  WishlistBtnClkEvent({required this.clickedProduct});
}

class CartBtnClkEvent extends HomeEvent {
  final ProductModel clickedProduct;

  CartBtnClkEvent({required this.clickedProduct});
}

class WishlistBtnClkNavEvent extends HomeEvent {}

class CartBtnClkNavEvent extends HomeEvent {}
