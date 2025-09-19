import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post_model.dart';

abstract class PostLocalDataSource {
  Future<void> cachePost(PostModel post);

  Future<void> removePost(PostModel post);

  Future<List<PostModel>> getOfflinePosts();
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences prefs;
  static const String cachedPostsKey = 'CACHED_POSTS';

  PostLocalDataSourceImpl({required this.prefs});

  @override
  Future<void> cachePost(PostModel post) async {
    final current = prefs.getStringList(cachedPostsKey) ?? [];
    final exists = current.any((s) {
      final decoded = PostModel.fromJson(json.decode(s));
      return decoded.id == post.id;
    });

    if (!exists) {
      final newList = List<String>.from(current)
        ..add(json.encode(post.toJson()));
      await prefs.setStringList(cachedPostsKey, newList);
    }
  }

  @override
  Future<void> removePost(PostModel post) async {
    final current = prefs.getStringList(cachedPostsKey) ?? [];
    final newList = current.where((s) {
      final decoded = PostModel.fromJson(json.decode(s));
      return decoded.id != post.id;
    }).toList();

    await prefs.setStringList(cachedPostsKey, newList);
  }

  @override
  Future<List<PostModel>> getOfflinePosts() async {
    final list = prefs.getStringList(cachedPostsKey) ?? [];
    return list.map((s) => PostModel.fromJson(json.decode(s))).toList();
  }
}
