import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/blog.dart';
import '../data/repository/blog_repository.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  final BlogRepository blogRepository;

  BlogCubit(this.blogRepository) : super(BlogLoading()) {
    fetchBlogs();
  }

  // Fetch blogs
  Future<void> fetchBlogs() async {
    emit(BlogLoading());
    try {
      final blogs = await blogRepository.fetchBlogs(); 
      print(blogs);
      emit(BlogLoaded(blogs));
    } catch (e) {
      emit(BlogError('Failed to fetch blogs: $e'));
    }
  }

   Future<void> updateBlog(Blog blog) async {
    emit(BlogUpdating()); 
    try {
      final updatedBlog = await blogRepository.updateBlog(blog);
      emit(BlogUpdated(updatedBlog));
      fetchBlogs(); 
    } catch (e) {
      emit(BlogError('Failed to update blog: $e'));
    }
  }
  // Add a new blog
  // Future<void> addBlog(Blog blog) async {
  //   if (state is BlogLoaded) {
  //     final currentBlogs = (state as BlogLoaded).blogs;
  //     try {
  //       // Call API to add the blog
  //       await blogRepository.addBlog(blog);
  //       emit(BlogLoaded([...currentBlogs, blog])); // Update state with the new blog
  //     } catch (e) {
  //       emit(BlogError('Failed to add blog: $e'));
  //     }
  //   }
  // }

  // Delete a blog
  // Future<void> deleteBlog(String id) async {
  //   if (state is BlogLoaded) {
  //     final currentBlogs = (state as BlogLoaded).blogs;
  //     try {
  //       // Call API to delete the blog
  //       await blogRepository.deleteBlog(id);
  //       final updatedBlogs =
  //           currentBlogs.where((blog) => blog.id != id).toList();
  //       emit(BlogLoaded(updatedBlogs)); // Update state after deletion
  //     } catch (e) {
  //       emit(BlogError('Failed to delete blog: $e'));
  //     }
  //   }
  // }
}
