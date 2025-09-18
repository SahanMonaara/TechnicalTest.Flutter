import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../presentation/pages/comments_page.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/post_details_page.dart';

class AppRouter {
  late final GoRouter router;

  // Private singleton constructor
  AppRouter._internal() {
    router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(
          path: '/post/:id',
          builder: (context, state) =>
              PostDetailsPage(postId: int.parse(state.pathParameters['id']!)),
        ),
        GoRoute(
          path: '/post/:id/comments',
          builder: (context, state) =>
              CommentsPage(postId: int.parse(state.pathParameters['id']!)),
        ),
      ],
    );
  }

  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter.instance() => _instance;

  void goHome(BuildContext context) => router.go('/');

  void goToPost(BuildContext context, int postId) => router.go('/post/$postId');

  void goToComments(BuildContext context, int postId) =>
      router.go('/post/$postId/comments');
}
