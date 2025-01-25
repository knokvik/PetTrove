import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pettrove/cubit/cart_cubit.dart';
import 'package:pettrove/cubit/cart_state.dart';
import 'package:pettrove/models/products.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              if (state.cartItems.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Empty Cart!',
                      style: TextStyle(
                        fontFamily: "Neue Plak",
                        fontSize: 30,
                      )
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 30 ),
                      child: Text(
                        "It seems like you haven't added anything to your cart yet. Let's find some great items to fill it up!",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }
              return ListView.builder(
                itemCount: state.cartItems.length,
                itemBuilder: (context, index) {
                  final product = state.cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Dismissible(
                      key: Key(product.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        context.read<CartCubit>().removeProduct(product);
                      },
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Spacer(),
                            SvgPicture.string(trashIcon),
                          ],
                        ),
                      ),
                      child: CartCard(product: product),
                    ),
                  );
                },
              );
            } else if (state is CartError) {
              return Center(child: Text(state.errorMessage));
            }
            else {
              return const Center(child: Text("Error loading cart"));
            }
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            return CheckoutCard(
              subtotal: state.subtotal,
              shippingFee: state.shippingFee,
              discount: state.discount,
              total: state.total,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class CartCard extends StatelessWidget {
  final Product product;

  const CartCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(product.imagePath),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.title,
              style: const TextStyle(color: Color.fromRGBO(22, 51, 0, 1), fontSize: 20, fontFamily: "Neue Plak"),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: "\$${product.price}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(137, 204, 95, 1),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class CheckoutCard extends StatelessWidget {
  final double subtotal;
  final double shippingFee;
  final double discount;
  final double total;

  const CheckoutCard({
    Key? key,
    required this.subtotal,
    required this.shippingFee,
    required this.discount,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color.fromARGB(85, 214, 200, 200),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Summary",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Neue Plak",
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                color: Color.fromARGB(255, 59, 56, 56),
              ),
            ),
            const SizedBox(height: 6),
            _buildSummaryRow("Subtotal:", subtotal.toStringAsFixed(2)),
            _buildSummaryRow("Shipping Fee:", shippingFee.toStringAsFixed(2)),
            _buildSummaryRow("Discount:", discount.toStringAsFixed(2)),
            const Divider(),
            _buildSummaryRow("Total (Including VAT):", total.toStringAsFixed(2)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(159, 232, 112, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Color.fromRGBO(22, 51, 0, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 67, 66, 63)),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold , color: Color.fromARGB(255, 66, 62, 62)),
          ),
        ],
      ),
    );
  }
}

void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[100],
        title: const Text("Confirm Checkout",
        style: TextStyle(
                fontSize: 22,
                fontFamily: "Neue Plak",
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                color: Color.fromARGB(255, 59, 56, 56),
              ),),
        content: const Text("Are you sure you want to proceed with this order?"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final userDataString = prefs.getString('currentUser');

                        if (userDataString == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Error: No user is logged in."),
                            ),
                          );
                          return;
                        }

                        // Decode user data from JSON
                        final userData = jsonDecode(userDataString);

                        // Get userId from the user data
                        final userId = userData['id'];

                        if (userId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Error: Unable to retrieve user ID."),
                            ),
                          );
                          return;
                        }

                        // Send cart data to the server
                        BlocProvider.of<CartCubit>(context).sendCartToServer(userId);

                        Navigator.pop( context );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(159, 232, 112, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                          color: Color.fromRGBO(22, 51, 0, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

const receiptIcon =
    '''<svg width="16" height="20" viewBox="0 0 16 20" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M2.18 19.85C2.27028 19.9471 2.3974 20.0016 2.53 20H2.82C2.9526 20.0016 3.07972 19.9471 3.17 19.85L5 18C5.19781 17.8082 5.51219 17.8082 5.71 18L7.52 19.81C7.61028 19.9071 7.7374 19.9616 7.87 19.96H8.16C8.2926 19.9616 8.41972 19.9071 8.51 19.81L10.32 18C10.5136 17.8268 10.8064 17.8268 11 18L12.81 19.81C12.9003 19.9071 13.0274 19.9616 13.16 19.96H13.45C13.5826 19.9616 13.7097 19.9071 13.8 19.81L15.71 18C15.8947 17.8137 15.9989 17.5623 16 17.3V1C16 0.447715 15.5523 0 15 0H1C0.447715 0 0 0.447715 0 1V17.26C0.00368349 17.5248 0.107266 17.7784 0.29 17.97L2.18 19.85ZM9 11.5C9 11.7761 8.77614 12 8.5 12H4.5C4.22386 12 4 11.7761 4 11.5V10.5C4 10.2239 4.22386 10 4.5 10H8.5C8.77614 10 9 10.2239 9 10.5V11.5ZM11.5 8C11.7761 8 12 7.77614 12 7.5V6.5C12 6.22386 11.7761 6 11.5 6H4.5C4.22386 6 4 6.22386 4 6.5V7.5C4 7.77614 4.22386 8 4.5 8H11.5Z" fill="#FF7643"/>
</svg>
''';

const trashIcon =
    '''<svg width="18" height="20" viewBox="0 0 18 20" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M10.7812 15.6604V7.16981C10.7812 6.8566 11.0334 6.60377 11.3438 6.60377C11.655 6.60377 11.9062 6.8566 11.9062 7.16981V15.6604C11.9062 15.9736 11.655 16.2264 11.3438 16.2264C11.0334 16.2264 10.7812 15.9736 10.7812 15.6604ZM6.09375 15.6604V7.16981C6.09375 6.8566 6.34594 6.60377 6.65625 6.60377C6.9675 6.60377 7.21875 6.8566 7.21875 7.16981V15.6604C7.21875 15.9736 6.9675 16.2264 6.65625 16.2264C6.34594 16.2264 6.09375 15.9736 6.09375 15.6604ZM15 16.6038C15 17.8519 13.9903 18.8679 12.75 18.8679H5.25C4.00969 18.8679 3 17.8519 3 16.6038V3.96226H15V16.6038ZM7.21875 1.50943C7.21875 1.30094 7.38656 1.13208 7.59375 1.13208H10.4062C10.6134 1.13208 10.7812 1.30094 10.7812 1.50943V2.83019H7.21875V1.50943ZM17.4375 2.83019H11.9062V1.50943C11.9062 0.677359 11.2331 0 10.4062 0H7.59375C6.76688 0 6.09375 0.677359 6.09375 1.50943V2.83019H0.5625C0.252187 2.83019 0 3.08302 0 3.39623C0 3.70943 0.252187 3.96226 0.5625 3.96226H1.875V16.6038C1.875 18.4764 3.38906 20 5.25 20H12.75C14.6109 20 16.125 18.4764 16.125 16.6038V3.96226H17.4375C17.7488 3.96226 18 3.70943 18 3.39623C18 3.08302 17.7488 2.83019 17.4375 2.83019Z" fill="#FF4848"/>
</svg>''';