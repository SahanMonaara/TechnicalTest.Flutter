import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/post_repository.dart';
import 'comments_event.dart';
import 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final PostRepository repository;

  CommentsBloc({required this.repository}) : super(CommentsLoadInProgress()) {
    on<CommentsRequested>(_onCommentsRequested);
  }

  Future<void> _onCommentsRequested(
    CommentsRequested event,
    Emitter<CommentsState> emit,
  ) async {
    emit(CommentsLoadInProgress());
    try {
      final comments = await repository.fetchComments(event.postId);
      emit(CommentsLoadSuccess(comments));
    } catch (e) {
      emit(CommentsLoadFailure(e.toString()));
    }
  }
}
