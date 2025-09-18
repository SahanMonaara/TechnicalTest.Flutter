import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/localization/app_localization.dart';
import '../bloc/offline/offline_bloc.dart';
import '../bloc/offline/offline_event.dart';
import '../bloc/offline/offline_state.dart';
import 'posts_page.dart';
import 'offline_posts_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    // Trigger offline count for badge
    context.read<OfflineBloc>().add(OfflineCountRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.translate('app_title')),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: AppLocalizations.of(context)!.translate('all_posts')),
            Tab(
              child: BlocBuilder<OfflineBloc, OfflineState>(
                builder: (context, state) {
                  int badge = 0;
                  if (state is OfflineCountLoadSuccess) badge = state.count;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.translate('offline_posts'),
                      ),
                      if (badge > 0) ...[
                        const SizedBox(width: 6),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text(
                            '$badge',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [PostsPage(), OfflinePostsPage()],
      ),
    );
  }
}
