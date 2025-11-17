import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '设置与配置',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      appState.isLoggedIn
                          ? '欢迎，${appState.userName}！'
                          : '您尚未登录，部分功能需要登录后才能访问。',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('个人资料'),
                    subtitle: Text(
                      appState.isLoggedIn ? '查看和编辑您的个人信息' : '需要登录后才能访问',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => context.pushNamed('profile'),
                  ),
                  const Divider(height: 0),
                  if (appState.isLoggedIn)
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('退出登录'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        appState.logOut();
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text('已退出登录')));
                      },
                    )
                  else
                    ListTile(
                      leading: const Icon(Icons.login),
                      title: const Text('登录'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        final currentLocation = GoRouterState.of(
                          context,
                        ).uri.toString();
                        final encoded = Uri.encodeComponent(currentLocation);
                        context.go('/login?from=$encoded');
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('关于'),
                    subtitle: const Text('Go Router 学习项目 v1.0.0'),
                  ),
                  const Divider(height: 0),
                  ListTile(
                    leading: const Icon(Icons.menu_book),
                    title: const Text('查看文档'),
                    subtitle: const Text('查看 docs 目录下的详细文档'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('文档位置'),
                          content: const Text(
                            '详细的 go_router 文档位于项目根目录的 docs 文件夹中，'
                            '包含基础概念、导航方法、路由配置、重定向与守卫等内容。',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('知道了'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
