import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/localization/app_localization.dart';
import '../bloc/offline/offline_bloc.dart';
import '../bloc/offline/offline_event.dart';
import '../bloc/post_details/post_details_bloc.dart';
import '../bloc/post_details/post_details_event.dart';
import '../bloc/post_details/post_details_state.dart';
import 'comments_page.dart';

class PostDetailsPage extends StatelessWidget {
  final int postId;

  const PostDetailsPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    context.read<PostDetailsBloc>().add(PostDetailsRequested(postId));

    return Scaffold(
      appBar: AppBar(title:  Text(AppLocalizations.of(context)!.translate(
          'post_details'))),
      body: BlocBuilder<PostDetailsBloc, PostDetailsState>(
        builder: (context, state) {
          if (state is PostDetailsLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostDetailsLoadSuccess) {
            final post = state.post;
            final isSaved = state.isSavedOffline;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(post.body),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                        ),
                        label: Text(
                          isSaved
                              ? AppLocalizations.of(
                                  context,
                                )!.translate('saved_offline')
                              : AppLocalizations.of(
                                  context,
                                )!.translate('save_offline'),
                        ),
                        onPressed: () {
                          context.read<PostDetailsBloc>().add(
                            ToggleSaveOffline(post.id),
                          );
                          // update offline badge
                          context.read<OfflineBloc>().add(
                            OfflineCountRequested(),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.comment),
                        label: Text(AppLocalizations.of(context)!.translate(
                            'view_comments')),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CommentsPage(postId: post.id),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is PostDetailsLoadFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
