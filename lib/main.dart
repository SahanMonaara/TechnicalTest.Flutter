import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/localization/app_localization.dart';
import 'injection.dart';
import 'core/navigation/app_router.dart';
import 'presentation/bloc/posts/posts_bloc.dart';
import 'presentation/bloc/post_details/post_details_bloc.dart';
import 'presentation/bloc/comments/comments_bloc.dart';
import 'presentation/bloc/offline/offline_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = sl<AppRouter>().router;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<PostsBloc>()),
        BlocProvider(create: (_) => sl<PostDetailsBloc>()),
        BlocProvider(create: (_) => sl<CommentsBloc>()),
        BlocProvider(create: (_) => sl<OfflineBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Clean BLoC Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          tabBarTheme: TabBarThemeData(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
          ),
        ),

        routerConfig: router,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('es')],
      ),
    );
  }
}
