import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetPostDetails {
  final PostRepository repository;

  GetPostDetails(this.repository);

  Future<Post> call(int id) => repository.fetchPost(id);
}
