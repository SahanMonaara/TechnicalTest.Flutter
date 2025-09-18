import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;

  const PostTile({super.key, required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(
        post.body.length > 50 ? '${post.body.substring(0, 50)}...' : post.body,
      ),
      onTap: onTap,
    );
  }
}
