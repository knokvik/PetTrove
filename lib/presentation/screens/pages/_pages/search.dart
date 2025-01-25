import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettrove/cubit/products.dart';
import 'package:pettrove/models/products.dart';
import 'package:pettrove/presentation/screens/pages/_pages/product.dart';

class ProductSearchPage extends StatefulWidget {
  @override
  _ProductSearchPageState createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        title: Text(
          'Search',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            fontFamily: "Neue Plak",
            color: Color.fromRGBO(22, 51, 0, 1),
            letterSpacing: 0.8,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                _searchProducts();
              },
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
                contentPadding: EdgeInsets.symmetric(vertical: 24),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color.fromARGB(70, 213, 213, 213)),
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
            SizedBox(height: 6),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoaded) {
                    final productsToShow = _filteredProducts.isNotEmpty 
                        ? _filteredProducts 
                        : state.products;

                    return ListView.builder(
                      itemCount: productsToShow.length,
                      itemBuilder: (context, index) {
                        final product = productsToShow[index];
                        return ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                          title: Text(product.title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Neue Plak",
                                color: Color.fromRGBO(22, 51, 0, 1),
                                letterSpacing: 0.8,
                              ),
                          ),
                          subtitle:
                              Text(product.description),
                          trailing:
                              Text('\$${product.price}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ProductDetailsScreen(product: product,),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _searchProducts() {
    final searchTerm = _searchController.text.toLowerCase();
    final productCubit = context.read<ProductCubit>();

    if (productCubit.state is ProductLoaded) {
      setState(() {
        _filteredProducts = (productCubit.state as ProductLoaded)
            .products
            .where((product) =>
                product.title.toLowerCase().contains(searchTerm) ||
                product.description.toLowerCase().contains(searchTerm))
            .toList();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
