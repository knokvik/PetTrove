import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Matches AppBar and body background
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding around body content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
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
            SizedBox(height: 16), // Add spacing
            // Blog list
            ListView.builder(
              shrinkWrap: true, // Add this to prevent infinite height issue
              physics: NeverScrollableScrollPhysics(), // Prevent scrolling inside the ListView
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                return BlogCard(blog: blogs[index]);
              },
            ),
          ],
        ),
      ),
    ),
        );
  }
}



class BlogCard extends StatelessWidget {
  final Blog blog;
  const BlogCard({required this.blog});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5 , horizontal: 5),
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
                blog.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6 ,horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Neue Plak",
                     letterSpacing: 1.2,
                     color: const Color.fromARGB(255, 54, 54, 54)
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  blog.content,
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogDetailPage(blog: blog),
                        ),
                      );
                    },
                    child: Text('Read More' , style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: const Color.fromARGB(255, 88, 92, 88)),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BlogDetailPage extends StatelessWidget {
  final Blog blog;

  const BlogDetailPage({required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                blog.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              blog.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              blog.fullContent,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class Blog {
  final String title;
  final String content;
  final String fullContent;
  final String imageUrl;

  Blog({
    required this.title,
    required this.content,
    required this.fullContent,
    required this.imageUrl,
  });
}

List<Blog> blogs = [
  Blog(
    title: 'Can Dogs Eat Cherries?',
    content: 'Cherries are harmful for dogs primarily because the pit, leaves and stem contain cyanide, which is toxic to dogs',
    fullContent: 'Cherries are harmful for dogs primarily because the pit, leaves and stem contain cyanide, which is toxic to dogs. Further, the pit can potentially cause an intestinal blockage.  The cyanide found within cherries is toxic to dogs if ingested in large enough quantities. A single cherry pit or stem often isn’t enough to cause cyanide poisoning, but there’s no reason to take the risk. Additionally, if ingested, the cherry pits can be a choking hazard or create an intestinal obstruction. While the flesh of the cherry contains vitamins A and C, fiber and antioxidants, it’s also been known to cause upset stomach in dogs. ',
    imageUrl: 'https://imgs.search.brave.com/yCxKtDRU6LdA-FaZO38kAJCT3hXS1RHLo5mGehfIp9k/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/ZG9nc3Rlci5jb20v/d3AtY29udGVudC91/cGxvYWRzLzIwMTgv/MDQvYmVybmVzZS1t/b3VudGFpbi1kb2ct/d2Fsa3Mtb24tYS1s/ZWFzaF9Lb2tva29s/YS1TaHV0dGVyc3Rv/Y2suanBn',
  ),
  Blog(
    title: 'State Management in Flutter',
    content: 'Managing state is an essential part of building Flutter apps... Discover various approaches.',
    fullContent: 'Managing state is an essential part of building Flutter apps. There are various approaches to managing state, such as Provider, Riverpod, and Bloc, each offering unique advantages depending on the complexity of the app.',
    imageUrl: 'https://imgs.search.brave.com/LrgfNDbRHrXvwIg2MEFOhiZCQCAMh7CmqDe8X5W9dIg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTcy/MDUwMzg5L3Bob3Rv/L2RvbWVzdGljLWNh/dC1odW50aW5nLWZv/ci1taWNlLWluLXRo/ZS1nYXJkZW4uanBn/P3M9NjEyeDYxMiZ3/PTAmaz0yMCZjPUJ0/LXhsd2pCeEVFMTB3/VF9mMDNTMllYOWtr/cGduN1Z5TDhRSG9t/aWU1VHM9',
  ),
];
