
import 'package:bloc/bloc.dart';
import 'package:mystore/models/product_model.dart';

class CartState{
  final List<ProductModel> products;

  CartState({required this.products});

  void addProductToCart(ProductModel product){
    products.add(product);
  }
  void removeProductFromCart(ProductModel product){
    products.remove(product);
  }

  bool isProductInCart(ProductModel product){
    return products.contains(product);
  }

  int totlaPrice(){
    return products.fold(0, (previousValue, element) => previousValue + element.price);
  }
}

class CartStateCubit extends Cubit<CartState>{  
  CartStateCubit() : super(CartState(products: []));

  void addProductToCart(ProductModel product){
    state.addProductToCart(product);
    // emit state will update the ui
    emit(state);
  }

  void removeProductFromCart(ProductModel product){
    state.removeProductFromCart(product);
    emit(state);
  }
}