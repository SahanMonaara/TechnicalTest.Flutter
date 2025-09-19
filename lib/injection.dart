import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/navigation/app_router.dart';
import 'data/datasources/post_remote_data_source.dart';
import 'data/datasources/post_local_data_source.dart';
import 'data/repositories/post_repository_impl.dart';
import 'domain/repositories/post_repository.dart';
import 'presentation/bloc/posts/posts_bloc.dart';
import 'presentation/bloc/post_details/post_details_bloc.dart';
import 'presentation/bloc/comments/comments_bloc.dart';
import 'presentation/bloc/offline/offline_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<AppRouter>(() => AppRouter.instance());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<PostLocalDataSource>(
    () => PostLocalDataSourceImpl(prefs: sl()),
  );
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(remote: sl(), local: sl()),
  );
  sl.registerFactory(() => PostsBloc(repository: sl()));
  sl.registerFactory(() => PostDetailsBloc(repository: sl()));
  sl.registerFactory(() => CommentsBloc(repository: sl()));
  sl.registerFactory(() => OfflineBloc(repository: sl()));
}
