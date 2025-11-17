import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('个人资料')),
      body: AnimatedBuilder(
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
                        '欢迎，${appState.userName}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 12),
                      const Text('这是一个通过路由守卫保护的页面。只有在登录状态下才能访问。'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.check_circle_outline),
                      title: const Text('当前登录状态'),
                      subtitle: Text(appState.isLoggedIn ? '已登录' : '未登录'),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('退出登录'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        appState.logOut();
                        context.goNamed('home');
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
