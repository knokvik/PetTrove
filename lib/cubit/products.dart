import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pettrove/data/repository/product_repository.dart';
import 'package:pettrove/models/products.dart';


// State
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  const ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}

// Cubit
class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit(this.productRepository) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final products = await productRepository.fetchProducts();
      emit(ProductLoaded(products.cast<Product>()));
    } catch (e) {
      emit(ProductError("Failed to load products."));
    }
  }

  // Filter products by category (e.g., Dog, Cat)
  List<Product> filterProducts(String category) {
  if (state is ProductLoaded) {
    final allProducts = (state as ProductLoaded).products;
    // Filter the products based on the category
    return allProducts.where((product) => product.category == category).toList();
  }
  return []; 
}

 List<Product> filterPets(String pet) {
  if (state is ProductLoaded) {
    final allProducts = (state as ProductLoaded).products;
    // Filter the products based on the category
    return allProducts.where((product) => product.pet == pet).toList();
  }
  return []; 
}

}
