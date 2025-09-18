import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../models/comment_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();

  Future<PostModel> getPost(int id);

  Future<List<CommentModel>> getComments(int postId);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  static const baseUrl = 'https://jsonplaceholder.typicode.com';

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await client.get(Uri.parse('$baseUrl/posts/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<PostModel> getPost(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/posts/$id/'));
    if (response.statusCode == 200) {
      return PostModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Future<List<CommentModel>> getComments(int postId) async {
    final response =
        await client.get(Uri.parse('$baseUrl/posts/$postId/comments/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => CommentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
