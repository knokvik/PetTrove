import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettrove/models/products.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartLoading()) {
    loadCart();
  }

 void loadCart() async {
  emit(CartLoading());

  try {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cartItems') ?? '[]';

    // Log the cart data to verify it
    print("Cart data from SharedPreferences: $cartData");

    final List<Product> cartItems = (json.decode(cartData) as List)
        .map((item) {
          if (item['title'] != null && item['name'] == null) {
            item['name'] = item['title']; // Map 'title' to 'name'
          }
          return Product.fromJson(item);
        })
        .toList();

    final double subtotal = calculateSubtotal(cartItems);
    const double shippingFee = 5.0;
    const double discount = 0.0;
    final double total = subtotal + shippingFee - discount;

    emit(CartLoaded(
      cartItems: cartItems,
      subtotal: subtotal,
      shippingFee: shippingFee,
      discount: discount,
      total: total,
    ));
  } catch (e, stackTrace) {
    print("Error loading cart: $e\n$stackTrace");
    emit(CartError(errorMessage: "Failed to load cart"));
  }
}
Future<void> sendCartToServer(String userId) async {
  if (state is CartLoaded) {
    final currentState = state as CartLoaded;

    if (currentState.cartItems.isEmpty) {
      print("Cart is empty. Nothing to send to the server.");
      emit(CartError(errorMessage: "Cart is empty. Cannot send to server."));
      return;
    }

    try {
      final url = Uri.parse('https://clever-shape-81254.pktriot.net/api/cart'); // Replace with your actual endpoint

      // Prepare the cart data with userId
      final cartData = {
        'userId': userId, // Include the userId in the request payload
        'cartItems': currentState.cartItems.map((item) => item.toJson()).toList(),
      };

      // Send the data to the server
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(cartData),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print("Cart saved successfully on the server: $responseBody");

      } else {
        print("Failed to save cart. Server responded with status: ${response.statusCode}");
        print("Response body: ${response.body}");
        emit(CartError(
          errorMessage: "Failed to save cart. Server responded with status: ${response.statusCode}",
        ));
      }
    } catch (e) {
      print("Error sending cart to server: $e");
      emit(CartError(errorMessage: "Error sending cart to server: $e"));
    }
  } else {
    print("Cart is not loaded. Cannot send to server.");
    emit(CartError(errorMessage: "Cart is not loaded. Cannot send to server."));
  }
}

  // Add a product to the cart and save to SharedPreferences
  void addProductToCart(Product product) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;

      // Add the product to the cart
      final updatedCartItems = List<Product>.from(currentState.cartItems)
        ..add(product);

      // Save to SharedPreferences
      await _saveCartToPrefs(updatedCartItems);

      // Emit the updated state
      emit(CartLoaded(
        cartItems: updatedCartItems,
        subtotal: calculateSubtotal(updatedCartItems),
        shippingFee: currentState.shippingFee,
        discount: currentState.discount,
        total: calculateTotal(updatedCartItems),
      ));
    }
  }

  // Remove a product from the cart and save to SharedPreferences
  void removeProduct(Product product) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;

      // Remove the product from the cart
      final updatedCartItems = List<Product>.from(currentState.cartItems)
        ..removeWhere((item) => item.id == product.id);

      // Save to SharedPreferences
      await _saveCartToPrefs(updatedCartItems);

      // Emit the updated state
      emit(CartLoaded(
        cartItems: updatedCartItems,
        subtotal: calculateSubtotal(updatedCartItems),
        shippingFee: currentState.shippingFee,
        discount: currentState.discount,
        total: calculateTotal(updatedCartItems),
      ));
    } else {
      emit(CartError(errorMessage: "Error removing product from cart"));
    }
  }

  // Helper method to save the cart to SharedPreferences
  Future<void> _saveCartToPrefs(List<Product> cartItems) async {
   final prefs = await SharedPreferences.getInstance();

    final cartData = jsonEncode(
      cartItems.map((item) {
        final json = item.toJson();
        json['name'] = json['title']; // Add 'name' key for compatibility
        json.remove('title');        // Remove 'title' key if it exists
        return json;
      }).toList(),
    );

    await prefs.setString('cartItems', cartData);
    print("Cart saved successfully: $cartData");
  }


  double calculateSubtotal(List<Product> cartItems) {
    return cartItems.fold(0.0, (sum, product) => sum + product.price);
  }

  double calculateTotal(List<Product> cartItems) {
    double subtotal = calculateSubtotal(cartItems);
    double shippingFee = 5.0; // Example
    double discount = 0.0;    // Example
    return subtotal + shippingFee - discount;
  }
}
