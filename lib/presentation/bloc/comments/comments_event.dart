import 'package:equatable/equatable.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object?> get props => [];
}

class CommentsRequested extends CommentsEvent {
  final int postId;

  const CommentsRequested(this.postId);

  @override
  List<Object?> get props => [postId];
}
