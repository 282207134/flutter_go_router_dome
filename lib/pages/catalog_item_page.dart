import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CatalogItemPage extends StatelessWidget {
  const CatalogItemPage({
    super.key,
    required this.id,
    required this.highlighted,
  });

  final String id;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final category = state.uri.queryParameters['category'];

    return Scaffold(
      appBar: AppBar(title: const Text('目录详情')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: highlighted
                ? Theme.of(context).colorScheme.secondaryContainer
                : null,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '项目编号：$id',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  _KeyValueRow(label: '类别', value: category ?? '未提供'),
                  const Divider(),
                  _KeyValueRow(label: '高亮显示', value: highlighted ? '是' : '否'),
                  const Divider(),
                  _KeyValueRow(label: '当前路径', value: state.uri.toString()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.arrow_back),
                  title: const Text('返回上一层'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.pop(),
                ),
                const Divider(height: 0),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('返回首页'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.goNamed('home'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
