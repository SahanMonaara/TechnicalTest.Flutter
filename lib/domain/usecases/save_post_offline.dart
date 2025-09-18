import '../entities/post.dart';
import '../repositories/post_repository.dart';

class SavePostOffline {
  final PostRepository repository;

  SavePostOffline(this.repository);

  Future<void> call(Post post) => repository.savePostOffline(post);
}
