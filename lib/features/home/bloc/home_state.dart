import 'package:flutter/cupertino.dart';

import '../../models/product_model.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductModel> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

class HomeNavToWishlistState extends HomeActionState {}

class HomeNavToCartState extends HomeActionState {}

class WishListAddedState extends HomeActionState {}

class CartAddedState extends HomeActionState {}
