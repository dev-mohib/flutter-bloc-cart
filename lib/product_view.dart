import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore/models/product_model.dart';
import 'package:mystore/state/cart_cubit.dart';
import 'package:mystore/state/product_cubit.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  void initState() {
    // load products
    BlocProvider.of<ProductStateCubit>(context).loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: BlocBuilder<ProductStateCubit, ProductState>(
        builder: (context, state) {
          if (state.status == AppStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 4,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: state.products[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                product.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              '\$${product.price}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: BlocBuilder<CartStateCubit, CartState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      if (state.isProductInCart(product)) {
                        state.removeProductFromCart(product);
                      } else {
                        state.addProductToCart(product);
                      }
                    },
                    icon: state.isProductInCart(product) ?  Icon(Icons.remove_shopping_cart, color: Colors.blue) : Icon(Icons.add_shopping_cart, color: Colors.grey),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
