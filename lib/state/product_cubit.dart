

import 'package:bloc/bloc.dart';
import 'package:mystore/models/product_model.dart';
import 'package:mystore/repository/product_repository.dart';

enum AppStatus{initial, loading, loaded, error}

class ProductState {
  final AppStatus status;
  final List<ProductModel> products;
  final String? error;

  ProductState({
    required this.status,
    required this.products,
    required this.error
  });

  ProductState copyWith({
    AppStatus? status,
    List<ProductModel>? products,
    String? error
  }) => ProductState(
    status: status ?? this.status,
    products: products ?? this.products,
    error: error ?? this.error
  );
}

class ProductStateCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;
  ProductStateCubit({required this.productRepository}) : super(ProductState(status: AppStatus.initial, products: [], error: null));

  Future<void> loadProducts() async {
    try {
      final products = await productRepository.getProducts();
      emit(state.copyWith(status: AppStatus.loaded, products: products));
    } catch (e) {
      emit(state.copyWith(status: AppStatus.error, error: e.toString()));
    }
  }
}