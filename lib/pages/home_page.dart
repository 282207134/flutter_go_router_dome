import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _HeaderCard(appState: appState),
        const SizedBox(height: 16),
        _NavigationExamples(appState: appState),
      ],
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Go Router 学习项目', style: theme.textTheme.headlineSmall),
                const SizedBox(height: 12),
                const Text(
                  '通过下方示例可以学习 go_router 的常用导航方法、参数传递、守卫、'
                  '自定义转场以及 StatefulShellRoute 等高级特性。',
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      appState.isLoggedIn ? Icons.verified : Icons.lock_open,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      appState.isLoggedIn
                          ? '当前登录用户：${appState.userName}'
                          : '当前处于未登录状态',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NavigationExamples extends StatelessWidget {
  const _NavigationExamples({required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.directions_run),
            title: const Text('context.goNamed'),
            subtitle: const Text('替换当前页面并跳转到设置页'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => context.goNamed('settings'),
          ),
          const Divider(height: 0),
          ListTile(
            leading: const Icon(Icons.directions_walk),
            title: const Text('context.pushNamed'),
            subtitle: const Text('压栈并传递路径参数、查询参数'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => context.pushNamed(
              'catalog-item',
              pathParameters: {'id': '101'},
              queryParameters: {'highlighted': 'true'},
            ),
          ),
          const Divider(height: 0),
          ListTile(
            leading: const Icon(Icons.autorenew),
            title: const Text('context.replaceNamed'),
            subtitle: const Text('替换当前路由，跳转到目录页'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => context.replaceNamed('catalog'),
          ),
          const Divider(height: 0),
          ListTile(
            leading: const Icon(Icons.forum),
            title: const Text('context.pushNamed + extra'),
            subtitle: const Text('携带额外数据并打开详情页'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => context.pushNamed(
              'home-details',
              pathParameters: {'id': 'extra-demo'},
              extra: '通过 extra 传递的数据',
            ),
          ),
          const Divider(height: 0),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('路由守卫'),
            subtitle: Text(
              appState.isLoggedIn ? '已登录，可直接访问 Profile' : '未登录，尝试访问将被重定向到登录页',
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => context.goNamed('profile'),
          ),
          const Divider(height: 0),
          ListTile(
            leading: const Icon(Icons.slideshow),
            title: const Text('自定义转场 Animation'),
            subtitle: const Text('以淡入淡出的方式展示模态页'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => context.pushNamed('home-modal'),
          ),
        ],
      ),
    );
  }
}
