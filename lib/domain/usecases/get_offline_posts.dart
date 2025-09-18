import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetOfflinePosts {
  final PostRepository repository;

  GetOfflinePosts(this.repository);

  Future<List<Post>> call() => repository.fetchOfflinePosts();
}
