import 'dart:async';
import 'package:mystore/models/product_model.dart';

List<ProductModel> productsList = [
  ProductModel(id: '1', name: 't-shirt', price: 100, image: 't-shirt.jpg'),
  ProductModel(id: '2', name: 'Bag', price: 150, image: 'bag.jpg'),
  ProductModel(id: '3', name: 'Glasses', price: 20, image: 'glasses.jpg'),
  ProductModel(id: '4', name: 'Jeans', price: 150, image: 'jeans.jpg'),
  ProductModel(id: '5', name: 'Shoes', price: 160, image: 'shoe.jpg'),
  ProductModel(id: '6', name: 'White Cap', price: 85, image: 'cap.jpg'),
];
class ProductRepository{

  Future<List<ProductModel>> getProducts() async{
    final products  = await Future.delayed(const Duration(seconds: 1)).then((value) => productsList);
    return products;
  }
}