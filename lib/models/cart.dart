import 'package:equatable/equatable.dart';
import 'package:pettrove/models/products.dart';

class Cart extends Equatable {
  final List<Product> products;

  Cart({
    this.products = const [],
  });

  Cart copyWith({List<Product>? products}) {
    return Cart(
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [products];
}
