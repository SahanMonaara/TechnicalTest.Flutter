import 'package:flutter/material.dart';
import 'package:flutter_tech_task/domain/entities/post.dart';
import 'package:flutter_tech_task/presentation/bloc/posts/posts_bloc.dart';
import 'package:flutter_tech_task/presentation/bloc/posts/posts_event.dart';
import 'package:flutter_tech_task/presentation/bloc/posts/posts_state.dart';
import 'package:flutter_tech_task/presentation/pages/posts_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockPostsBloc extends MockBloc<PostsEvent, PostsState>
    implements PostsBloc {}

void main() {
  late MockPostsBloc mockPostsBloc;

  setUp(() {
    mockPostsBloc = MockPostsBloc();
  });

  testWidgets('should display CircularProgressIndicator when loading', (
    WidgetTester tester,
  ) async {
    when(() => mockPostsBloc.state).thenReturn(PostsLoadInProgress());
    whenListen(
      mockPostsBloc,
      Stream<PostsState>.fromIterable([PostsLoadInProgress()]),
      initialState: PostsLoadInProgress(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<PostsBloc>.value(
            value: mockPostsBloc,
            child: const PostsPage(),
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display posts when state is PostsLoadSuccess', (
    WidgetTester tester,
  ) async {
    final posts = [Post(id: 1, title: 'Test', body: 'Body')];

    when(() => mockPostsBloc.state).thenReturn(PostsLoadSuccess(posts));
    whenListen(
      mockPostsBloc,
      Stream<PostsState>.fromIterable([PostsLoadSuccess(posts)]),
      initialState: PostsLoadSuccess(posts),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<PostsBloc>.value(
            value: mockPostsBloc,
            child: const PostsPage(),
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Test'), findsOneWidget);
    expect(find.text('Body'), findsOneWidget);
  });
}
