import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<dynamic> orders = []; // Store the orders
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('currentUser');

    if (userDataString == null) {
      setState(() {
        isLoading = false;
        errorMessage = 'User not logged in.';
      });
      return;
    }

    final userData = jsonDecode(userDataString);
    final userId = userData['id'];

    final url = Uri.parse(
        'https://clever-shape-81254.pktriot.net/order/?userId=$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      // Check if the `orders` field exists and is valid
      if (responseBody.containsKey('orders') &&
          responseBody['orders'] is Map<String, dynamic> &&
          responseBody['orders']['orders'] is List<dynamic>) {
        setState(() {
          orders = responseBody['orders']['orders']; // Adjusted for nested structure
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Unexpected response format.';
        });
      }
    } else {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to fetch orders. Try again later.';
      });
    }
  } catch (e) {
    setState(() {
      isLoading = false;
      errorMessage = 'An error occurred: $e';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        title: const Text('Orders',
        style: TextStyle(
                    color: Color.fromRGBO(22, 51, 0, 1),
                    fontSize: 20,
                    fontFamily: "Neue Plak",
                    fontWeight: FontWeight.bold,
                  ),),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : orders.isEmpty
                  ? const Center(child: Text('No orders found.'))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];

                          if (order == null || order['products'] == null) {
                            return const ListTile(
                              title: Text('Invalid order data.'),
                            );
                          }

                          final products = order['products'] as List<dynamic>;
                          final orderDate =
                              DateTime.parse(order['orderDate']);
                          final totalBill = products.fold<double>(
                            0,
                            (sum, product) =>
                                sum + (product['price'] as num).toDouble(),
                          );

                          return Container(
                            margin: EdgeInsets.symmetric( vertical: 8 ),
                            padding: EdgeInsets.symmetric( horizontal: 8 ,vertical: 16 ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35)
                            ),
                            child: ListTile(
                              title: Text(
                                'Order ${index + 1}',
                                style: TextStyle(
                                  color: Color.fromRGBO(22, 51, 0, 1),
                                  fontSize: 20,
                                  fontFamily: "Neue Plak",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Products: ${products.length}\nDate: ${orderDate.toLocal()}',
                              ),
                              trailing: const Icon(Icons.arrow_forward,color: Color.fromRGBO(22, 51, 0, 1),size:30,),
                              onTap: () {
                                _showOrderDetails(context, products, totalBill);
                              },
                            ),
                          );
                        },
                      ),
                    ),
    );
  }

  void _showOrderDetails(
      BuildContext context, List<dynamic> products, double totalBill) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          title: const Text('Order Details',style: TextStyle(
                    color: Color.fromRGBO(22, 51, 0, 1),
                    fontFamily: "Neue Plak",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...products.map((product) {
                  return ListTile(
                    leading: Image.network(
                      product['imagePath'] ?? '',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product['title'] ?? 'No title'),
                    subtitle: Text(
                      '\$${(product['price'] ?? 0).toStringAsFixed(2)}',
                    ),
                  );
                }).toList(),
                const Divider(),
                Text(
                  'Total Bill: \$${totalBill.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
