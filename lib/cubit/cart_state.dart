import 'package:equatable/equatable.dart';
import 'package:pettrove/models/products.dart';

class CartState extends Equatable {
  final List<Product> cartItems;
  final double subtotal;
  final double shippingFee;
  final double discount;
  final double total;

  const CartState({
    this.cartItems = const [],
    this.subtotal = 0.0,
    this.shippingFee = 0.0,
    this.discount = 0.0,
    this.total = 0.0,
  });

  CartState copyWith({
    List<Product>? cartItems,
    double? subtotal,
    double? shippingFee,
    double? discount,
    double? total,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      subtotal: subtotal ?? this.subtotal,
      shippingFee: shippingFee ?? this.shippingFee,
      discount: discount ?? this.discount,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [cartItems, subtotal, shippingFee, discount, total];
}

class CartInitial extends CartState {
  const CartInitial() : super();
}

class CartLoading extends CartState {
  const CartLoading() : super();
}

class CartLoaded extends CartState {
  const CartLoaded({
    required List<Product> cartItems,
    required double subtotal,
    required double shippingFee,
    required double discount,
    required double total,
  }) : super(
          cartItems: cartItems,
          subtotal: subtotal,
          shippingFee: shippingFee,
          discount: discount,
          total: total,
        );
}

class CartError extends CartState {
  final String errorMessage;

  const CartError({
    required this.errorMessage,
    List<Product> cartItems = const [],
    double subtotal = 0.0,
    double shippingFee = 0.0,
    double discount = 0.0,
    double total = 0.0,
  }) : super(
          cartItems: cartItems,
          subtotal: subtotal,
          shippingFee: shippingFee,
          discount: discount,
          total: total,
        );

  @override
  List<Object?> get props => [errorMessage, ...super.props];
}

