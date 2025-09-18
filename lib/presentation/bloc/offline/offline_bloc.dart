import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/post_repository.dart';
import 'offline_event.dart';
import 'offline_state.dart';

class OfflineBloc extends Bloc<OfflineEvent, OfflineState> {
  final PostRepository repository;

  OfflineBloc({required this.repository}) : super(OfflineInitial()) {
    on<OfflinePostsRequested>(_onOfflinePostsRequested);
    on<OfflineCountRequested>(_onOfflineCountRequested);
  }

  Future<void> _onOfflinePostsRequested(
    OfflinePostsRequested event,
    Emitter<OfflineState> emit,
  ) async {
    emit(OfflineLoadInProgress());
    try {
      final posts = await repository.fetchOfflinePosts();
      emit(OfflineLoadSuccess(posts));
    } catch (e) {
      emit(OfflineLoadFailure(e.toString()));
    }
  }

  Future<void> _onOfflineCountRequested(
    OfflineCountRequested event,
    Emitter<OfflineState> emit,
  ) async {
    try {
      final posts = await repository.fetchOfflinePosts();
      emit(OfflineCountLoadSuccess(posts.length));
    } catch (_) {
      emit(const OfflineCountLoadSuccess(0));
    }
  }
}
