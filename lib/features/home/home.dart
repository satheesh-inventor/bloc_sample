import 'package:blocsample/features/home/bloc/home_bloc.dart';
import 'package:blocsample/features/home/bloc/home_state.dart';
import 'package:blocsample/features/home/product_tile_widget.dart';
import 'package:blocsample/features/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../card/cart.dart';
import 'bloc/home_event.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavToCartState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNavToWishlistState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WishList()));
        } else if (state is WishListAddedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Item Added to wishList')));
        } else if (state is CartAddedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Item Added to Cart')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successstate = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                centerTitle: true,
                title: Text("Pandian Stores"),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(WishlistBtnClkNavEvent());
                    },
                    icon: Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(CartBtnClkNavEvent());
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              body: ListView.builder(
                  itemCount: successstate.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                        homeBloc: homeBloc,
                        productModel: successstate.products[index]);
                  }),
            );
          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
