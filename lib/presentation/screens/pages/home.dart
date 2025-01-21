import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pettrove/cubit/products.dart';
import 'package:pettrove/data/repository/product_repository.dart';
import 'package:pettrove/models/products.dart';
import 'package:pettrove/presentation/screens/pages/_pages/pet.dart';
import 'package:pettrove/presentation/screens/pages/_pages/product.dart';

class Home extends StatelessWidget {
  final ProductRepository productRepository;

  // Constructor to initialize ProductRepository
  Home({Key? key, required this.productRepository}) : super(key: key);

   late GoogleMapController mapController;

    final LatLng sahasNgoLocation = LatLng(18.523339, 73.8845124);

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(18.6376282, 73.760302,),
    zoom: 12,
  );

  final List<Marker> _markers = [
    Marker(
      markerId: MarkerId('sahas_ngo'),
      position: LatLng(18.523339, 73.8845124),
      infoWindow: InfoWindow(
        title: 'Sahas NGO',
        snippet: 'A wonderful place for pets!',
      ),
    ),
  ];

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
                child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(9, 0, 0, 0), // Shadow color
                      blurRadius: 3,
                      offset: Offset(1,3), // Shadow offset
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '   What do you need for your pet?',
                    hintStyle: TextStyle(
                      color: const Color.fromARGB(255, 83, 83, 83),
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
                          color: const Color.fromARGB(205, 34, 33, 33),
                        ),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
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
              )
              ),  
              SizedBox(height: 10),
               Container(
                
                margin: EdgeInsets.symmetric( horizontal: 6 ),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(
                    color: const Color.fromARGB(1, 158, 158, 158).withOpacity(0.5), // Border color
                    width: 0.4, // Border width
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(23, 91, 91, 91), // Shadow color
                      blurRadius: 3,
                      offset: Offset(3,3), // Shadow offset
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: sahasNgoLocation,
                      zoom: 15, // Adjusted zoom for better visibility
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('sahasNgo'),
                        position: sahasNgoLocation,
                        infoWindow: InfoWindow(
                          title: 'Sahas NGO',
                          snippet: 'Location of Sahas NGO',
                        ),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed, // Red marker color
                        ),
                      ),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                  ),
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