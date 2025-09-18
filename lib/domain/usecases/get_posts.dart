import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetPosts {
  final PostRepository repository;

  GetPosts(this.repository);

  Future<List<Post>> call() => repository.fetchPosts();
}
