import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettrove/cubit/products.dart';
import 'package:pettrove/data/repository/product_repository.dart';
import 'package:pettrove/models/products.dart';
import 'package:pettrove/presentation/screens/pages/_pages/pet.dart';
import 'package:pettrove/presentation/screens/pages/_pages/product.dart';

class Home extends StatelessWidget {
  final ProductRepository productRepository;

  // Constructor to initialize ProductRepository
  Home({Key? key, required this.productRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: ' What do you need for your pet?',
                    focusColor: Color.fromRGBO(22, 51, 0, 1),
                    fillColor: Color.fromRGBO(22, 51, 0, 1),
                    hoverColor: Color.fromRGBO(22, 51, 0, 1),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 18), // Move icon slightly right
                      child: Icon(
                        Icons.search,
                        color: Color.fromRGBO(22, 51, 0, 1), // Set icon color to black
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 25),
                  ),
                ),
              ),  
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(159, 232, 112, 1),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Get 10% off by TRANSFER pet food',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          fontFamily: "Neue Plak",
                          color: Color.fromRGBO(22, 51, 0, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Category',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Neue Plak",
                  color: Color.fromRGBO(22, 51, 0, 1),
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 10),
                // Updated category icons with container
              Row(
                children: [
                  Expanded(child: _buildCategoryItem("https://imgs.search.brave.com/id3fXtn6EnildU7-QUsEuVkjMg1GnLsHvi_m8YNa-0k/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMuZnJlZWltYWdl/cy5jb20vaW1hZ2Vz/L2xhcmdlLXByZXZp/ZXdzL2ViYy9qb3lm/dWwtd2hpdGUtZG9n/LWluLW5hdHVyZS0w/NDEwLTU2OTcyODAu/anBnP2ZtdA", 'Dog',context)),
                  Expanded(child: _buildCategoryItem("https://imgs.search.brave.com/ftEl3u43Gu5W6XCXPzCLtyk5firttASYM538uS0s37w/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTgy/MTc2MzUxL3Bob3Rv/L2EtcGljdHVyZS1v/Zi1hLWNhdC1vbi1h/LXdoaXRlLWJhY2tn/cm91bmQtbG9va2lu/Zy11cC5qcGc_cz02/MTJ4NjEyJnc9MCZr/PTIwJmM9cjIxMk5V/cEYxb0tKWFU3TVpk/LXFlX2hST2MxZXNw/SDVxRENzaEtrYWtS/ST0", 'Cat',context)),
                  Expanded(child: _buildCategoryItem("https://imgs.search.brave.com/ZCKidoWJnSiU5qpU7Fqi7uK-bkLWOqUTPko8K-HX084/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA5LzE1LzI4LzU5/LzM2MF9GXzkxNTI4/NTk4NF9hcHNDS3Bq/Qzh0Um9jMzhzd0tG/MTR1TzNxRVNCeEFz/dS5qcGc", 'Hamster',context)),
                  Expanded(child: _buildCategoryItem("https://imgs.search.brave.com/Ij84sm1tIqi6Ew4YXDXhcAMURRSxgx7uz5kFUvfjlhQ/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9hLXot/YW5pbWFscy5jb20v/bWVkaWEvcmFiYml0/LTMtNzY4eDUxMi5q/cGc", 'Rabbit',context)),
                ],
              ),
              SizedBox(height: 20),
              BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  // Filter the products directly within the builder
                  final List<Product> filteredProducts = context.read<ProductCubit>().filterProducts("Accessories");
                  return _buildProductSection("Pet Accessories", filteredProducts , context);
                } else {
                  print(state);
                  return Center(child: Text("Failed to load products"));
                }
              },
            ),
              SizedBox(height: 20),
              BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  // Filter the products directly within the builder
                  final List<Product> filteredProducts = context.read<ProductCubit>().filterProducts("Food");
                  return _buildProductSection("Pet Food", filteredProducts , context);
                } else {
                  print(state);
                  return Center(child: Text("Failed to load products"));
                }
              },
            ),
              SizedBox(height: 20),
              BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  // Filter the products directly within the builder
                  final List<Product> filteredProducts = context.read<ProductCubit>().filterProducts("Toys");
                  return _buildProductSection("Pet Toys", filteredProducts , context);
                } else {
                  print(state);
                  return Center(child: Text("Failed to load products"));
                }
              },
            ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductSection(String title, List<Product> products , BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            fontFamily: "Neue Plak",
            color: Color.fromRGBO(22, 51, 0, 1),
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: products.map((product) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(product: product),
                      ),
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        product.imagePath,
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String imagePath, String label , BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(label),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(38), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 35,
            backgroundImage: NetworkImage(imagePath),  // Makes the image circular
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 10),
        ],
      )
      
      ),
    );
   }
  }