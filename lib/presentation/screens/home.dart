import 'dart:ui';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

   int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        toolbarHeight: 76,
        backgroundColor: Colors.grey[100], 
        elevation: 0, 
        title: Column(
          children: [
            SizedBox(height: 6,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6 ,),
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
                        Text('Greeselia M.', style: TextStyle(color: Colors.black,fontSize: 14)),
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
                icon: Icon(Icons.notifications_outlined, color: Color.fromRGBO(22, 51, 0, 1),size: 25,),
                onPressed: () {
                //   Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => EmptyNotificationsScreen()),
                // );
                },
              ),
            ),
          ),
        ],
      ),

      body:  
      // _currentIndex == 0 ? 
      SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
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
                    color: Color.fromRGBO(159, 232, 112,1),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                        'Get 10% off by TRANSFER pet food',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600, 
                          letterSpacing: 1.2,
                          fontFamily: "Neue Plak",
                          color: Color.fromRGBO(22, 51, 0, 1),
                          height: 1.2
                        ),
                      )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Category label
                Text('  Category', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400,fontFamily: "Neue Plak",color: Color.fromRGBO(22, 51, 0, 1),letterSpacing: 0.8)),
                SizedBox(height: 10),
                // Updated category icons with container
                Row(
                  children: [
                    Expanded(child: _buildCategoryItem("https://imgs.search.brave.com/id3fXtn6EnildU7-QUsEuVkjMg1GnLsHvi_m8YNa-0k/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMuZnJlZWltYWdl/cy5jb20vaW1hZ2Vz/L2xhcmdlLXByZXZp/ZXdzL2ViYy9qb3lm/dWwtd2hpdGUtZG9n/LWluLW5hdHVyZS0w/NDEwLTU2OTcyODAu/anBnP2ZtdA", 'Dog')),
                    Expanded(child: _buildCategoryItem("https://imgs.search.brave.com/ftEl3u43Gu5W6XCXPzCLtyk5firttASYM538uS0s37w/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTgy/MTc2MzUxL3Bob3Rv/L2EtcGljdHVyZS1v/Zi1hLWNhdC1vbi1h/LXdoaXRlLWJhY2tn/cm91bmQtbG9va2lu/Zy11cC5qcGc_cz02/MTJ4NjEyJnc9MCZr/PTIwJmM9cjIxMk5V/cEYxb0tKWFU3TVpk/LXFlX2hST2MxZXNw/SDVxRENzaEtrYWtS/ST0", 'Cat')),
                    Expanded(child: _buildCategoryItem("https://imgs.search.brave.com/ZCKidoWJnSiU5qpU7Fqi7uK-bkLWOqUTPko8K-HX084/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA5LzE1LzI4LzU5/LzM2MF9GXzkxNTI4/NTk4NF9hcHNDS3Bq/Qzh0Um9jMzhzd0tG/MTR1TzNxRVNCeEFz/dS5qcGc", 'Hamster')),
                    Expanded(child: _buildCategoryItem("https://imgs.search.brave.com/Ij84sm1tIqi6Ew4YXDXhcAMURRSxgx7uz5kFUvfjlhQ/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9hLXot/YW5pbWFscy5jb20v/bWVkaWEvcmFiYml0/LTMtNzY4eDUxMi5q/cGc", 'Rabbit')),
                  ],
                ),
                SizedBox(height: 20),
                  // Scrollable sections for products
                  _buildProductSection('  Pet Accessories', [
                    "https://imgs.search.brave.com/cq9jkXLZ_KoRmqvBe8tpa80XnA015UmvzpK87qxd4pU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9mdW5u/eWZ1enp5LmNvbS9j/ZG4vc2hvcC9maWxl/cy9EZW5pbUxpZ250/Qmx1ZS5qcGc_dj0x/NzE3NDkwNTUxJndp/ZHRoPTEwMDA", 
                    "https://imgs.search.brave.com/yhRRtAuk_r_k_VwA7Wx68xRYIESPjh4T8IpCp_deTOw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/aWtlYS5jb20vdXMv/ZW4vaW1hZ2VzL3By/b2R1Y3RzL3V0c2Fk/ZC1wZXQtYm93bC1z/dHJpcGUtcGF0dGVy/bi1ibGFjay1ibHVl/LWdyYXktYmx1ZV9f/MTI4MTYyMF9wZTkz/MTk2Ml9zNS5qcGc_/Zj14eHM", 
                    "https://imgs.search.brave.com/LhMNCeA02h7FBnqBj8uJ_etYe0lhwcHWYbiWvrX7nNo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4x/MS5iaWdjb21tZXJj/ZS5jb20vcy1wdXNl/aGp4L2ltYWdlcy9z/dGVuY2lsLzM4MHgz/ODAvcHJvZHVjdHMv/NzA4NC8yMjE5Mi9w/ZXRfcmVzdHJhaW50/XzE1MDB4MTAwMF9f/MjE1MjYuMTcwNTM2/MDUwNi5qcGc_Yz0y", 
                    "https://imgs.search.brave.com/m1prUKOncusnR_BmKcCoGSyI27cakD35hnpogWjz3-k/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/aWtlYS5jb20vdXMv/ZW4vaW1hZ2VzL3By/b2R1Y3RzL3V0c2Fk/ZC1zbnVmZmxlLW1h/dC1mb3ItZG9nLWJs/dWVfXzEyMjcyODRf/cGU5MTU1OTFfczUu/anBnP2Y9eHhz"
                  ]),
                  SizedBox(height: 20),
                  _buildProductSection('  Pet Food', [
                    "https://imgs.search.brave.com/cq9jkXLZ_KoRmqvBe8tpa80XnA015UmvzpK87qxd4pU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9mdW5u/eWZ1enp5LmNvbS9j/ZG4vc2hvcC9maWxl/cy9EZW5pbUxpZ250/Qmx1ZS5qcGc_dj0x/NzE3NDkwNTUxJndp/ZHRoPTEwMDA", 
                    "https://imgs.search.brave.com/yhRRtAuk_r_k_VwA7Wx68xRYIESPjh4T8IpCp_deTOw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/aWtlYS5jb20vdXMv/ZW4vaW1hZ2VzL3By/b2R1Y3RzL3V0c2Fk/ZC1wZXQtYm93bC1z/dHJpcGUtcGF0dGVy/bi1ibGFjay1ibHVl/LWdyYXktYmx1ZV9f/MTI4MTYyMF9wZTkz/MTk2Ml9zNS5qcGc_/Zj14eHM", 
                    "https://imgs.search.brave.com/LhMNCeA02h7FBnqBj8uJ_etYe0lhwcHWYbiWvrX7nNo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4x/MS5iaWdjb21tZXJj/ZS5jb20vcy1wdXNl/aGp4L2ltYWdlcy9z/dGVuY2lsLzM4MHgz/ODAvcHJvZHVjdHMv/NzA4NC8yMjE5Mi9w/ZXRfcmVzdHJhaW50/XzE1MDB4MTAwMF9f/MjE1MjYuMTcwNTM2/MDUwNi5qcGc_Yz0y", 
                    "https://imgs.search.brave.com/m1prUKOncusnR_BmKcCoGSyI27cakD35hnpogWjz3-k/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/aWtlYS5jb20vdXMv/ZW4vaW1hZ2VzL3By/b2R1Y3RzL3V0c2Fk/ZC1zbnVmZmxlLW1h/dC1mb3ItZG9nLWJs/dWVfXzEyMjcyODRf/cGU5MTU1OTFfczUu/anBnP2Y9eHhz"
                  ]),
                  SizedBox(height: 20),
                  _buildProductSection('  Pet Toys', [
                    "https://imgs.search.brave.com/cq9jkXLZ_KoRmqvBe8tpa80XnA015UmvzpK87qxd4pU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9mdW5u/eWZ1enp5LmNvbS9j/ZG4vc2hvcC9maWxl/cy9EZW5pbUxpZ250/Qmx1ZS5qcGc_dj0x/NzE3NDkwNTUxJndp/ZHRoPTEwMDA", 
                    "https://imgs.search.brave.com/yhRRtAuk_r_k_VwA7Wx68xRYIESPjh4T8IpCp_deTOw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/aWtlYS5jb20vdXMv/ZW4vaW1hZ2VzL3By/b2R1Y3RzL3V0c2Fk/ZC1wZXQtYm93bC1z/dHJpcGUtcGF0dGVy/bi1ibGFjay1ibHVl/LWdyYXktYmx1ZV9f/MTI4MTYyMF9wZTkz/MTk2Ml9zNS5qcGc_/Zj14eHM", 
                    "https://imgs.search.brave.com/LhMNCeA02h7FBnqBj8uJ_etYe0lhwcHWYbiWvrX7nNo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4x/MS5iaWdjb21tZXJj/ZS5jb20vcy1wdXNl/aGp4L2ltYWdlcy9z/dGVuY2lsLzM4MHgz/ODAvcHJvZHVjdHMv/NzA4NC8yMjE5Mi9w/ZXRfcmVzdHJhaW50/XzE1MDB4MTAwMF9f/MjE1MjYuMTcwNTM2/MDUwNi5qcGc_Yz0y", 
                    "https://imgs.search.brave.com/m1prUKOncusnR_BmKcCoGSyI27cakD35hnpogWjz3-k/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/aWtlYS5jb20vdXMv/ZW4vaW1hZ2VzL3By/b2R1Y3RzL3V0c2Fk/ZC1zbnVmZmxlLW1h/dC1mb3ItZG9nLWJs/dWVfXzEyMjcyODRf/cGU5MTU1OTFfczUu/anBnP2Y9eHhz"
                  ]),
              ],
            ),
          ),
          
        ) 
        // : _currentIndex == 1 ? BlogPage() : _currentIndex == 3 ? CartScreen() : _currentIndex == 4 ? ProfileScreen() : null
        ,
      
    bottomNavigationBar: Container(
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
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(Icons.home_outlined, 0),
              _buildNavItem(Icons.newspaper_outlined, 1),
              _buildNavItem(Icons.arrow_upward, 2, isCenter: true),
              _buildNavItem(Icons.shopping_cart_outlined, 3),
              _buildNavItem(Icons.person_outline, 4),
            ],
          ),
        ),
      ),
    ));
      }

  Widget _buildNavItem(IconData icon, int index,  {bool isCenter = false}) {
  bool isSelected = _currentIndex == index;
  return GestureDetector(
    onTap: () => _onItemTapped(index),
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
        color: isSelected  || index == 2 ? Color.fromRGBO(22, 51, 0, 1) : Colors.grey ,
      ),
    ),
  );
}


    Widget _buildProductSection(String title, List<String> imagePath) {
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
            children: imagePath.map((icon) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                  //   Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ProductDetailsScreen()),
                  // );
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
                      borderRadius: BorderRadius.circular(30),  // Match container's border radius
                      child: Image.network(
                        icon,
                        fit: BoxFit.cover,  // Ensures the image covers the container
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

}


  
  // Helper method to build category items with background container
  Widget _buildCategoryItem(String imagePath, String label) {
    return Container(
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

    );
  }

