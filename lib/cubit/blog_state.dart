part of 'blog_cubit.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object?> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;

  const BlogLoaded(this.blogs);

  @override
  List<Object?> get props => [blogs];
}

class BlogError extends BlogState {
  final String message;

  const BlogError(this.message);

  @override
  List<Object?> get props => [message];
}

class BlogUpdating extends BlogState {}

class BlogUpdated extends BlogState {
  final Blog blog;

  const BlogUpdated(this.blog);

  @override
  List<Object?> get props => [blog];
}