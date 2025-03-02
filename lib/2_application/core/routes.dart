import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/2_application/core/go_router_observer.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/details/todo_details_page.dart';
import 'package:todo_app/2_application/pages/home/home_page.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

const _basePath = '/home';

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '$_basePath/${DashboardPage.pageConfig.name}',
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      name: SettingsPage.pageConfig.name,
      path: '$_basePath/${SettingsPage.pageConfig.name}',
      builder: (context, state) => const SettingsPage(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: HomePage.pageConfig.name,
          path: '$_basePath/:tab',
          builder: (context, state) => HomePage(
            key: state.pageKey,
            tab: state.pathParameters['tab'] ?? 'dashboard',
          ),
        ),
        GoRoute(
          name: ToDoDetailsPage.pageConfig.name,
          path: '$_basePath/overview/:collectionId',
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: const Text('details'),
              leading: BackButton(
                onPressed: () {
                  if(context.canPop()){
                    context.pop();
                  } else {
                    context.goNamed(
                      HomePage.pageConfig.name,
                      pathParameters: {'tab': OverviewPage.pageConfig.name},
                    );
                  }
                },
              ),
            ),
            body: ToDoDetailsPageProvider(
                collectionId: CollectionId.fromUniqueString(
                    state.pathParameters['collectionId'] ?? '',
                ),
            ),
          ),
        ),
      ],
    ),
  ],
);
