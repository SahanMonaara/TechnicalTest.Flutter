import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/localization/app_localization.dart';
import '../bloc/comments/comments_bloc.dart';
import '../bloc/comments/comments_event.dart';
import '../bloc/comments/comments_state.dart';

class CommentsPage extends StatelessWidget {
  final int postId;

  const CommentsPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    context.read<CommentsBloc>().add(CommentsRequested(postId));

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('view_comments')),
      ),
      body: BlocBuilder<CommentsBloc, CommentsState>(
        builder: (context, state) {
          if (state is CommentsLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CommentsLoadSuccess) {
            final comments = state.comments;
            if (comments.isEmpty) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.translate('no_comments'),
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: comments.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  title: Text(comment.name),
                  subtitle: Text(comment.body),
                  trailing: Text(
                    comment.email,
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            );
          } else if (state is CommentsLoadFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
