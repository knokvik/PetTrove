import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettrove/cubit/products.dart';
import 'package:pettrove/models/products.dart';
import 'package:pettrove/presentation/screens/pages/_pages/product.dart';
import 'package:pettrove/presentation/screens/pages/_pages/search.dart';

class ProductPage extends StatelessWidget {
  final String category;

  ProductPage(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 245, 245, 245),
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(
          '$category',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            fontFamily: "Neue Plak",
            color: Color.fromRGBO(22, 51, 0, 1),
            height: 1.2,
          ),
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            // Filter the products based on the dynamic category
            final List<Product> filteredProducts = context.read<ProductCubit>().filterPets(category);
            return _buildProductSection(category, filteredProducts, context);
          } else {
            print(state);
            return Center(child: Text("Failed to load products"));
          }
        },
      ),
    );
  }

  // A function to build the product section layout
  Widget _buildProductSection(String sectionTitle, List<Product> products, BuildContext context) { 
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 16 , vertical: 6 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductSearchPage(),
                ),
              );
            },
            readOnly: true,
            decoration: InputDecoration(
              hintText: '   What do you need for your pet?',
              hintStyle: TextStyle(
                color: const Color.fromARGB(255, 59, 59, 59),
                fontSize: 15,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(159, 232, 112, 1),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(15),
                  child: Icon(
                    Icons.search,
                    color: const Color.fromARGB(192, 16, 16, 16),
                  ),
                ),
              ),
              filled: true,
              fillColor: Colors.grey[100],
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 24,),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: const Color.fromRGBO(164, 164, 164, 0.273)),
                borderRadius: BorderRadius.circular(50),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: products.map((product) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(product: product),
                      ),
                    );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 2 ,vertical: 10 ),
                      child: Row(
                        children: [
                          // Product image
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(35)),
                              child: Image.network(
                                product.imagePath,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          // Product details on the right
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.title,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Neue Plak",
                                    letterSpacing: 1.2,
                                    color: const Color.fromARGB(255, 54, 54, 54),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "$product.description,$product.description",
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13.7,
                                    wordSpacing: 0
                                  ),
                                ),
                                SizedBox(height: 18),
                                Text(
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600, 
                                  letterSpacing: 1.2,
                                  fontFamily: "Neue Plak",
                                  color: Color.fromRGBO(22, 51, 0, 1),
                                  height: 1.2
                                ),
                                'Price : \$${product.price.toString()}', // Use dynamic product title
                              ),
                              SizedBox( height: 5 ),
                              // ElevatedButton(
                              // style: ElevatedButton.styleFrom(
                              //   elevation: 0,
                              //   backgroundColor: Color.fromRGBO(158, 232, 112, 1),
                              //   foregroundColor: Colors.white,
                              //   shape: const RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.all(Radius.circular(35)),
                              //   ),
                              // ),
                              // onPressed: () {},
                              // child: Padding(
                              //   padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                              //   child: Text( "Add To Cart", 
                              //       style: const TextStyle(color: Colors.black, fontSize: 12),
                              //     ),
                              //   ),
                              // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
