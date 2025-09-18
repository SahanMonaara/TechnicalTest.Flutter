import 'package:equatable/equatable.dart';
import '../../../domain/entities/post.dart';

abstract class PostDetailsState extends Equatable {
  const PostDetailsState();

  @override
  List<Object?> get props => [];
}

class PostDetailsInitial extends PostDetailsState {}

class PostDetailsLoadInProgress extends PostDetailsState {}

class PostDetailsLoadSuccess extends PostDetailsState {
  final Post post;
  final bool isSavedOffline;

  const PostDetailsLoadSuccess({
    required this.post,
    required this.isSavedOffline,
  });

  @override
  List<Object?> get props => [post, isSavedOffline];

  PostDetailsLoadSuccess copyWith({Post? post, bool? isSavedOffline}) {
    return PostDetailsLoadSuccess(
      post: post ?? this.post,
      isSavedOffline: isSavedOffline ?? this.isSavedOffline,
    );
  }
}

class PostDetailsLoadFailure extends PostDetailsState {
  final String message;

  const PostDetailsLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
