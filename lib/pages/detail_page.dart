import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.id, this.from});

  final String id;
  final String? from;

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final extra = state.extra;

    return Scaffold(
      appBar: AppBar(title: const Text('详情页')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('参数演示', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  _InfoRow(label: '路径参数 (id)', value: id),
                  const Divider(),
                  _InfoRow(label: '查询参数 (from)', value: from ?? '未提供'),
                  const Divider(),
                  _InfoRow(
                    label: 'Extra 参数',
                    value: extra?.toString() ?? '未提供',
                  ),
                  const Divider(),
                  _InfoRow(label: '完整 Location', value: state.uri.toString()),
                  const Divider(),
                  _InfoRow(
                    label: 'Matched Location',
                    value: state.matchedLocation,
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
                  leading: const Icon(Icons.arrow_back),
                  title: const Text('context.pop()'),
                  subtitle: const Text('返回上一页'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.pop(),
                ),
                const Divider(height: 0),
                ListTile(
                  leading: const Icon(Icons.arrow_back_ios),
                  title: const Text('context.pop(result)'),
                  subtitle: const Text('返回并携带数据'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.pop('返回的数据：${DateTime.now()}'),
                ),
                const Divider(height: 0),
                ListTile(
                  leading: const Icon(Icons.push_pin),
                  title: const Text('继续 Push'),
                  subtitle: const Text('继续压栈新页面'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.pushNamed(
                    'home-details',
                    pathParameters: {
                      'id': 'nested-${DateTime.now().millisecondsSinceEpoch}',
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

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
            width: 140,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
