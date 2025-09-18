import 'package:flutter_tech_task/data/datasources/post_local_data_source.dart';
import 'package:flutter_tech_task/data/datasources/post_remote_data_source.dart';
import 'package:flutter_tech_task/data/models/post_model.dart';
import 'package:flutter_tech_task/data/repositories/post_repository_impl.dart';
import 'package:flutter_tech_task/domain/entities/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockRemoteDataSource extends Mock implements PostRemoteDataSource {}

class MockLocalDataSource extends Mock implements PostLocalDataSource {}

void main() {
  late PostRepositoryImpl repository;
  late MockRemoteDataSource mockRemote;
  late MockLocalDataSource mockLocal;

  setUp(() {
    mockRemote = MockRemoteDataSource();
    mockLocal = MockLocalDataSource();
    repository = PostRepositoryImpl(remote: mockRemote, local: mockLocal);
  });

  test('should return posts when remote data source succeeds', () async {
    // arrange
    final testPostModels = [
      PostModel(id: 1, title: 'Test Post', body: 'Body of post'),
    ];
    when(() => mockRemote.getPosts()).thenAnswer((_) async => testPostModels);

    // act
    final result = await repository
        .fetchPosts(); // repository converts PostModel -> Post

    // assert
    expect(result, isA<List<Post>>());
    expect(result.length, 1);
    expect(result[0].title, 'Test Post');

    verify(() => mockRemote.getPosts()).called(1);
    verifyNever(() => mockLocal.getOfflinePosts());
  });

  test('should throw exception when remote data source fails', () async {
    when(() => mockRemote.getPosts()).thenThrow(Exception());
    expect(() => repository.fetchPosts(), throwsException);
  });
}
