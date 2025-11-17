import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_state.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.navigationShell,
    required this.appState,
  });

  final StatefulNavigationShell navigationShell;
  final AppState appState;

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final destinations = _destinations;

    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(destinations[navigationShell.currentIndex].label),
            actions: [
              if (appState.isLoggedIn)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        appState.userName,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: '退出登录',
                      onPressed: appState.logOut,
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                )
              else
                TextButton.icon(
                  onPressed: () {
                    final currentLocation = GoRouterState.of(
                      context,
                    ).uri.toString();
                    final encoded = Uri.encodeComponent(currentLocation);
                    context.go('/login?from=$encoded');
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('登录'),
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                ),
            ],
          ),
          body: navigationShell,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: _onDestinationSelected,
            items: [
              for (final destination in destinations)
                BottomNavigationBarItem(
                  icon: Icon(destination.icon),
                  label: destination.label,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _Destination {
  const _Destination({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

const List<_Destination> _destinations = [
  _Destination(label: '首页', icon: Icons.home),
  _Destination(label: '示例', icon: Icons.menu_book),
  _Destination(label: '设置', icon: Icons.settings),
];
