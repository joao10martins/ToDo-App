import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/core/page_config.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/details/todo_details_page.dart';
import 'package:todo_app/2_application/pages/home/bloc/navigation_todo_cubit.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required String tab,
  }) : index = tabs.indexWhere((element) => element.name == tab);

  @override
  State<HomePage> createState() => _HomePageState();

  static const PageConfig pageConfig =
      PageConfig(icon: Icons.home_rounded, name: 'home');
  final int index;

  // list of all tabs that should be displayed inside our navigation bar
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
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('primary-navigation-medium'),
              builder: (context) => AdaptiveScaffold.standardNavigationRail(
                trailing: IconButton(
                  onPressed: () => context.pushNamed(SettingsPage.pageConfig.name),
                  icon: Icon(SettingsPage.pageConfig.icon),
                ),
                selectedLabelTextStyle:
                    TextStyle(color: theme.colorScheme.onSurface),
                selectedIconTheme:
                    IconThemeData(color: theme.colorScheme.onSurface),
                unselectedIconTheme: IconThemeData(
                    color: theme.colorScheme.onSurface.withOpacity(0.5)),
                selectedIndex: widget.index,
                destinations: destinations
                    .map((element) =>
                        AdaptiveScaffold.toRailDestination(element))
                    .toList(),
                onDestinationSelected: (index) =>
                    _tapOnNavigationDestination(context, index),
              ),
            ),
          }),
          bottomNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.small: SlotLayout.from(
              key: const Key('bottom-navigation-small'),
              builder: (context) =>
                  AdaptiveScaffold.standardBottomNavigationBar(
                currentIndex: widget.index,
                destinations: destinations.toList(),
                onDestinationSelected: (value) =>
                    _tapOnNavigationDestination(context, value),
              ),
            ),
          }),
          body: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.smallAndUp: SlotLayout.from(
              key: const Key('primary-body-small'),
              builder: (_) => HomePage.tabs[widget.index].child,
            ),
          }),
          secondaryBody: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('secondary-body-medium'),
              builder: widget.index != 1
                  ? null
                  : (_) => BlocBuilder<NavigationTodoCubit, NavigationTodoState>(
                      builder: (context, state) {
                        final selectedId = state.selectedCollectionId;
                        final isSecondBodyDisplayed = Breakpoints.mediumAndUp.isActive(context);

                        context.read<NavigationTodoCubit>().secondBodyHasChanged(isSecondBodyDisplayed: isSecondBodyDisplayed);

                        if(selectedId == null) return Placeholder();
                        return ToDoDetailsPageProvider(
                          key: Key(selectedId.value),
                          collectionId: selectedId,
                        );
                      },
              ),
            ),
          }),
        ),
      ),
    );
  }
}

void _tapOnNavigationDestination(BuildContext context, int index) =>
    context.goNamed(
      HomePage.pageConfig.name,
      pathParameters: {
        'tab': HomePage.tabs[index].name,
      },
    );
