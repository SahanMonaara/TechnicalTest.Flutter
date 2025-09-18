import 'package:equatable/equatable.dart';
import '../../../domain/entities/post.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsLoadInProgress extends PostsState {}

class PostsLoadSuccess extends PostsState {
  final List<Post> posts;

  const PostsLoadSuccess(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostsLoadFailure extends PostsState {
  final String message;

  const PostsLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
