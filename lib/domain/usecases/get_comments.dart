import '../entities/comment.dart';
import '../repositories/post_repository.dart';

class GetComments {
  final PostRepository repository;

  GetComments(this.repository);

  Future<List<Comment>> call(int postId) => repository.fetchComments(postId);
}
