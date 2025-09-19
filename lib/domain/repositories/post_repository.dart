import '../entities/post.dart';
import '../entities/comment.dart';

abstract class PostRepository {
  Future<List<Post>> fetchPosts();

  Future<Post> fetchPost(int id);

  Future<List<Comment>> fetchComments(int postId);

  Future<void> savePostOffline(Post post);

  Future<void> removePostOffline(Post post);

  Future<List<Post>> fetchOfflinePosts();
}
