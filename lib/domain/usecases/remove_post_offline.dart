import '../entities/post.dart';
import '../repositories/post_repository.dart';

class RemovePostOffline {
  final PostRepository repository;

  RemovePostOffline(this.repository);

  Future<void> call(Post post) => repository.savePostOffline(post);
}
