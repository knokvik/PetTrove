import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettrove/cubit/pages.dart';
import 'package:pettrove/cubit/products.dart';
import 'package:pettrove/data/repository/product_repository.dart';
import 'package:pettrove/presentation/screens/pages/blog.dart';
import 'package:pettrove/presentation/screens/pages/cart.dart';
import 'package:pettrove/presentation/screens/pages/home.dart';
import 'package:pettrove/presentation/screens/pages/profile.dart';

class CurrentPage extends StatefulWidget {
  @override
  _CurrentPageState createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  final ProductRepository productRepository = ProductRepository();

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProducts();
  }

  final List<Widget> pages = [
    Center(child: Home(productRepository: ProductRepository())),
    Center(child: BlogPage()),
    Center(child: Text('Profile')),
    Center(child: CartScreen()),
    Center(child: ProfileScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomePageCubit(), // Provide the HomePageCubit
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          toolbarHeight: 76,
          backgroundColor: Colors.grey[100],
          elevation: 0,
          title: Column(
            children: [
              SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Profile picture
                      CircleAvatar(
                        backgroundImage: AssetImage('images/pet.jpeg'),
                        radius: 23,
                      ),
                      SizedBox(width: 10),
                      // User information
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Greeselia M.', style: TextStyle(color: Colors.black, fontSize: 14)),
                          Text('Solo, Central Java', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(45),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.notifications_outlined, color: Color.fromRGBO(22, 51, 0, 1), size: 25),
                  onPressed: () {
                    // Navigator.push to notifications page (if needed)
                  },
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<HomePageCubit, int>( // Use the HomePageCubit
          builder: (context, selectedIndex) {
            return pages[selectedIndex]; // Update page based on selected index
          },
        ),
        bottomNavigationBar: BlocBuilder<HomePageCubit, int>( // Listen to state changes
          builder: (context, selectedIndex) {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: const Color.fromARGB(37, 158, 158, 158),
                    width: 1.0,
                  ),
                ),
              ),
              child: BottomAppBar(
                color: Colors.white,
                shape: CircularNotchedRectangle(),
                notchMargin: 8.0,
                child: Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildNavItem(context, Icons.home_outlined, 0, selectedIndex),
                      _buildNavItem(context, Icons.newspaper_outlined, 1, selectedIndex),
                      _buildNavItem(context, Icons.arrow_upward, 2, selectedIndex, isCenter: true),
                      _buildNavItem(context, Icons.shopping_cart_outlined, 3, selectedIndex),
                      _buildNavItem(context, Icons.person_outline, 4, selectedIndex),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Update the _buildNavItem function to accept the BuildContext explicitly
  Widget _buildNavItem(BuildContext context, IconData icon, int index, int selectedIndex, {bool isCenter = false}) {

  bool isSelected = context.watch<HomePageCubit>().state == index;
  
  return GestureDetector(
    onTap: () {
      context.read<HomePageCubit>().updateIndex(index); // Update index when tapped
    },
    child: AnimatedContainer(
      duration: Duration(milliseconds: 200),
        width: isSelected ? 55 : 45,   // Increase size when selected
        height: isSelected ? 55 : 45,
      decoration: BoxDecoration(
        color: index == 2 ? Color.fromRGBO(159, 232, 112,1) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: index == 2 ? 30 : 30,  // Increase icon size
        color: Color.fromRGBO(22, 51, 0, 1)  ,
      ),
    ),
  );
}

}
