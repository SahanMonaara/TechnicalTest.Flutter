import 'package:equatable/equatable.dart';

abstract class PostDetailsEvent extends Equatable {
  const PostDetailsEvent();

  @override
  List<Object?> get props => [];
}

class PostDetailsRequested extends PostDetailsEvent {
  final int postId;

  const PostDetailsRequested(this.postId);

  @override
  List<Object?> get props => [postId];
}

class ToggleSaveOffline extends PostDetailsEvent {
  final int postId;

  const ToggleSaveOffline(this.postId);

  @override
  List<Object?> get props => [postId];
}
