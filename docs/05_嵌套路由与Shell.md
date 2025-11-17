# 嵌套路由与 Shell

## 什么是嵌套路由？

嵌套路由允许你在父路由中定义子路由，子路由的完整路径是父路由路径加上子路由路径。

```dart
GoRoute(
  path: '/settings',
  builder: (context, state) => SettingsPage(),
  routes: [
    GoRoute(
      path: 'profile',  // 完整路径：/settings/profile
      builder: (context, state) => ProfileSettingsPage(),
    ),
    GoRoute(
      path: 'privacy',  // 完整路径：/settings/privacy
      builder: (context, state) => PrivacySettingsPage(),
    ),
  ],
)
```

## ShellRoute

`ShellRoute` 用于创建一个"外壳"，该外壳在导航到其子路由时保持不变。常用于底部导航栏、侧边栏等布局。

### 基本用法

```dart
final router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/explore',
          builder: (context, state) => ExplorePage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => ProfilePage(),
        ),
      ],
    ),
  ],
);
```

在 `ScaffoldWithNavBar` 中：

```dart
class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/explore')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/explore');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }
}
```

## StatefulShellRoute

`StatefulShellRoute` 允许在多个分支之间切换时保留每个分支的状态。

```dart
final router = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/explore',
              builder: (context, state) => ExplorePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
```

在 `ScaffoldWithNavBar` 中使用 `navigationShell`：

```dart
class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
```

## StatefulShellRoute 的优势

- **状态保持**：切换 Tab 时保留滚动位置、输入状态等
- **独立导航栈**：每个分支有自己的导航栈
- **性能优化**：使用 `IndexedStack` 缓存页面

## 嵌套路由的最佳实践

1. **合理规划路由层级**：不要嵌套过深
2. **使用 Shell 保持布局**：对于底部导航等固定布局，使用 ShellRoute
3. **状态管理**：对需要保持状态的页面使用 StatefulShellRoute
4. **路径命名**：确保子路由路径清晰、语义化

## 实际应用场景

- **底部导航栏**：使用 StatefulShellRoute
- **侧边栏导航**：使用 ShellRoute
- **多步骤表单**：使用嵌套 GoRoute
- **Tab 页面**：每个 Tab 使用 StatefulShellBranch
