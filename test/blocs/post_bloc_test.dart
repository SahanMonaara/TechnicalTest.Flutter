import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_tech_task/domain/entities/post.dart';
import 'package:flutter_tech_task/domain/repositories/post_repository.dart';
import 'package:flutter_tech_task/presentation/bloc/posts/posts_bloc.dart';
import 'package:flutter_tech_task/presentation/bloc/posts/posts_event.dart';
import 'package:flutter_tech_task/presentation/bloc/posts/posts_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late PostsBloc postsBloc;
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
    postsBloc = PostsBloc(repository: mockRepository);
  });

  final testPosts = [Post(id: 1, title: 'Test Post', body: 'Body of post')];

  blocTest<PostsBloc, PostsState>(
    'emits [PostsLoadInProgress, PostsLoadSuccess] when posts are fetched successfully',
    build: () {
      when(
        () => mockRepository.fetchPosts(),
      ).thenAnswer((_) async => testPosts);
      return postsBloc;
    },
    act: (bloc) => bloc.add(PostsRequested()),
    expect: () => [PostsLoadInProgress(), PostsLoadSuccess(testPosts)],
  );

  blocTest<PostsBloc, PostsState>(
    'emits [PostsLoadInProgress, PostsLoadFailure] when repository throws',
    build: () {
      when(() => mockRepository.fetchPosts()).thenThrow(Exception('Error'));
      return postsBloc;
    },
    act: (bloc) => bloc.add(PostsRequested()),
    expect: () => [PostsLoadInProgress(), isA<PostsLoadFailure>()],
  );
}
