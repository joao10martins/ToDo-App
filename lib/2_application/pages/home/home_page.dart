import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String tab}) : index = tabs.indexWhere((element) => element.name == tab);

  @override
  State<HomePage> createState() => _HomePageState();

  final int index;
  static const tabs = [
    DashboardPage.pageConfig,
    OverviewPage.pageConfig,
  ];
}

class _HomePageState extends State<HomePage> {
  final destinations = HomePage.tabs.map(
    (page) => NavigationDestination(
      icon: Icon(page.icon),
      label: page.name,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('primary-navigation-medium'),
              builder: (context) => AdaptiveScaffold.standardNavigationRail(
                destinations: destinations.map(
                      (element) => AdaptiveScaffold.toRailDestination(element),
                    ).toList(),
              ),
            ),
          }),
          bottomNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.small: SlotLayout.from(
              key: const Key('bottom-navigation-small'),
              builder: (context) =>
                  AdaptiveScaffold.standardBottomNavigationBar(
                      destinations: destinations.toList(),
                  ),
            ),
          }),
          body: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.smallAndUp: SlotLayout.from(
              key: const Key('primary-body'),
              builder: (context) => Placeholder(),
            ),
          }),
          secondaryBody: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('secondary-body'),
              builder: (context) => Placeholder(),
            ),
          }),
        ),
      ),
    );
  }
}
