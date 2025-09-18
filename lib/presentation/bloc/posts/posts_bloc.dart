import 'package:flutter_bloc/flutter_bloc.dart';
import 'posts_event.dart';
import 'posts_state.dart';
import '../../../domain/repositories/post_repository.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository repository;

  PostsBloc({required this.repository}) : super(PostsLoadInProgress()) {
    on<PostsRequested>(_onPostsRequested);
    on<OfflinePostsRequested>(_onOfflinePostsRequested);
  }

  Future<void> _onPostsRequested(
    PostsRequested event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoadInProgress());
    try {
      final posts = await repository.fetchPosts();
      emit(PostsLoadSuccess(posts));
    } catch (e) {
      emit(PostsLoadFailure(e.toString()));
    }
  }

  Future<void> _onOfflinePostsRequested(
    OfflinePostsRequested event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoadInProgress());
    try {
      final posts = await repository.fetchOfflinePosts();
      emit(PostsLoadSuccess(posts));
    } catch (e) {
      emit(PostsLoadFailure(e.toString()));
    }
  }
}
