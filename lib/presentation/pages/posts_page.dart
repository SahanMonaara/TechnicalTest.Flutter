import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection.dart';
import '../bloc/posts/posts_bloc.dart';
import '../bloc/posts/posts_event.dart';
import '../bloc/posts/posts_state.dart';
import '../widgets/post_tile.dart';
import '../../core/navigation/app_router.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PostsBloc>().add(PostsRequested());

    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostsLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostsLoadSuccess) {
          final posts = state.posts;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostTile(
                post: post,
                onTap: () {
                  sl<AppRouter>().goToPost(context, post.id);
                },
              );
            },
          );
        } else if (state is PostsLoadFailure) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
