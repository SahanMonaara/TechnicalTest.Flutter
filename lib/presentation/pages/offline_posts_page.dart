import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task/core/localization/app_localization.dart';
import '../../injection.dart';
import '../bloc/offline/offline_bloc.dart';
import '../bloc/offline/offline_event.dart';
import '../bloc/offline/offline_state.dart';
import '../widgets/post_tile.dart';
import '../../core/navigation/app_router.dart';

class OfflinePostsPage extends StatelessWidget {
  const OfflinePostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OfflineBloc>().add(OfflinePostsRequested());

    return BlocBuilder<OfflineBloc, OfflineState>(
      builder: (context, state) {
        if (state is OfflineLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OfflineLoadSuccess) {
          final posts = state.posts;
          if (posts.isEmpty) {
            return  Center(child: Text(AppLocalizations.of(context)!.translate(
                'no_offline_posts')));
          }
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
        } else if (state is OfflineLoadFailure) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
