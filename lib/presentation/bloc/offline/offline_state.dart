import 'package:equatable/equatable.dart';
import '../../../domain/entities/post.dart';

abstract class OfflineState extends Equatable {
  const OfflineState();

  @override
  List<Object?> get props => [];
}

class OfflineInitial extends OfflineState {}

class OfflineLoadInProgress extends OfflineState {}

class OfflineLoadSuccess extends OfflineState {
  final List<Post> posts;

  const OfflineLoadSuccess(this.posts);

  @override
  List<Object?> get props => [posts];
}

class OfflineCountLoadSuccess extends OfflineState {
  final int count;

  const OfflineCountLoadSuccess(this.count);

  @override
  List<Object?> get props => [count];
}

class OfflineLoadFailure extends OfflineState {
  final String message;

  const OfflineLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
