import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettrove/cubit/blog_cubit.dart';
import 'package:pettrove/data/repository/auth_repository.dart';
import 'package:pettrove/models/blog.dart';
import 'package:pettrove/presentation/screens/pages/_pages/upload.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Matches AppBar and body background
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              context.read<BlogCubit>().fetchBlogs(); // Trigger refresh
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search bar
                    const SizedBox(height: 16),
                    // Blog content based on state
                    BlocBuilder<BlogCubit, BlogState>(
                      builder: (context, state) {
                        if (state is BlogLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is BlogLoaded ) {
                          final blogs = state.blogs;
                          if (blogs.isEmpty) {
                            return const Center(child: Text("No blogs available."));
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: blogs.length,
                            itemBuilder: (context, index) {
                              return BlogCard(blog: blogs[index]);
                            },
                          );
                        } else if (state is BlogError) {
                          return Center(child: Text(state.message));
                        }
                        return const Center(child: Text("Something went wrong."));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: '',
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: Center(
                child: SizedBox(
                  child: Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Container(
                        color: Colors.grey[100],
                        height: 530,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ComposeBlogPage(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: Color.fromRGBO(159, 232, 112, 1), // Light green
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.add,
          size: 30,
          color: Color.fromRGBO(22, 51, 0, 1), // Dark green
        ),
      ),
    ),
    );
  }
}

class BlogCard extends StatelessWidget {
  final Blog blog;
  const BlogCard({required this.blog, super.key});

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
  height: 200, // Fixed height
  width: double.infinity,
  child: ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(35)),
    child: Image.network(
      blog.imagePath,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child; // Image has finished loading
        }
        return const Center(child: CircularProgressIndicator()); // Show a standard circular progress bar
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        return Center(
          child: Icon(
            Icons.broken_image,
            color: Colors.grey,
            size: 50,
          ),
        );
      },
    ),
  ),
),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Neue Plak",
                    letterSpacing: 1.2,
                    color: Color.fromARGB(255, 54, 54, 54),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  blog.description,
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
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
                    child: const Text(
                      'Read More',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 88, 92, 88),
                      ),
                    ),
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

  const BlogDetailPage({required this.blog, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(blog.title,style: TextStyle(fontFamily: "Neue Plak"),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.network(
                blog.imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              blog.title,
              style: const TextStyle(
                fontFamily: "Neue Plak",
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              blog.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      
    );
  }
}
