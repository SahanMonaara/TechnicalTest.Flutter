import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/post_repository.dart';
import 'post_details_event.dart';
import 'post_details_state.dart';

class PostDetailsBloc extends Bloc<PostDetailsEvent, PostDetailsState> {
  final PostRepository repository;

  PostDetailsBloc({required this.repository}) : super(PostDetailsInitial()) {
    on<PostDetailsRequested>(_onPostDetailsRequested);
    on<ToggleSaveOffline>(_onToggleSaveOffline);
  }

  Future<void> _onPostDetailsRequested(
    PostDetailsRequested event,
    Emitter<PostDetailsState> emit,
  ) async {
    emit(PostDetailsLoadInProgress());
    try {
      final post = await repository.fetchPost(event.postId);
      final offlinePosts = await repository.fetchOfflinePosts();
      final isSaved = offlinePosts.any((p) => p.id == post.id);
      emit(PostDetailsLoadSuccess(post: post, isSavedOffline: isSaved));
    } catch (e) {
      emit(PostDetailsLoadFailure(e.toString()));
    }
  }

  Future<void> _onToggleSaveOffline(
    ToggleSaveOffline event,
    Emitter<PostDetailsState> emit,
  ) async {
    final currentState = state;
    if (currentState is PostDetailsLoadSuccess) {
      final isSaved = currentState.isSavedOffline;
      try {
        if (!isSaved) {
          await repository.savePostOffline(currentState.post);
        } else {
          await repository.removePostOffline(currentState.post);
        }
        emit(currentState.copyWith(isSavedOffline: !isSaved));
      } catch (e) {
        emit(PostDetailsLoadFailure(e.toString()));
      }
    }
  }
}
