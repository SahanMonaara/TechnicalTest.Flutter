import '../../domain/entities/post.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_data_source.dart';
import '../datasources/post_local_data_source.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remote;
  final PostLocalDataSource local;

  PostRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<Post>> fetchPosts() async => remote.getPosts();

  @override
  Future<Post> fetchPost(int id) async => remote.getPost(id);

  @override
  Future<List<Comment>> fetchComments(int postId) async =>
      remote.getComments(postId);

  @override
  Future<void> savePostOffline(Post post) async {
    final model = PostModel(id: post.id, title: post.title, body: post.body);
    await local.cachePost(model);
  }

  @override
  Future<List<Post>> fetchOfflinePosts() async => local.getOfflinePosts();

  @override
  Future<void> removePostOffline(Post post) async{
    final model = PostModel(id: post.id, title: post.title, body: post.body);
    await local.removePost(model);
  }
}
