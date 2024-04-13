import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blocsample/data/cart_items.dart';
import 'package:blocsample/data/electrnics.dart';
import 'package:blocsample/data/wishlist_items.dart';
import 'package:blocsample/features/models/product_model.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<WishlistBtnClkNavEvent>(wishlistBtnClkNavEvent);
    on<CartBtnClkNavEvent>(cartBtnClkNavEvent);
    on<WishlistBtnClkEvent>(wishlistBtnClkEvent);
    on<CartBtnClkEvent>(cartBtnClkEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        products: Electronics.electronicItems
            .map((e) => ProductModel(
                name: e['name'],
                brand: e['brand'],
                model: e['model'],
                price: e['price'],
                image: e['image']))
            .toList()));
  }

  FutureOr<void> wishlistBtnClkNavEvent(
      WishlistBtnClkNavEvent event, Emitter<HomeState> emit) {
    print('Wishlist Nav pressed');
    emit(HomeNavToWishlistState());
  }

  FutureOr<void> cartBtnClkNavEvent(
      CartBtnClkNavEvent event, Emitter<HomeState> emit) {
    print('Cart is pressed');
    emit(HomeNavToCartState());
  }

  FutureOr<void> wishlistBtnClkEvent(
      WishlistBtnClkEvent event, Emitter<HomeState> emit) {
    print('Item is added to WishList');
    wishListItems.add(event.clickedProduct);
    emit(WishListAddedState());
  }

  FutureOr<void> cartBtnClkEvent(
      CartBtnClkEvent event, Emitter<HomeState> emit) {
    print('Item is Added to Cart');
    cartItems.add(event.clickedProduct);
    emit(CartAddedState());
  }
}
