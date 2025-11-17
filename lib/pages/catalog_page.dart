import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'Go Router 方法示例',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                const Text(
                  '点击下方列表项可查看不同导航方法的效果。'
                  '这些示例演示了如何传递路径参数和查询参数。',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(
          10,
          (index) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text('示例项目 ${index + 1}'),
              subtitle: Text('ID: catalog-${index + 1}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                context.pushNamed(
                  'catalog-item',
                  pathParameters: {'id': 'catalog-${index + 1}'},
                  queryParameters: {
                    'highlighted': (index % 2 == 0).toString(),
                    'category': index < 5 ? 'basic' : 'advanced',
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
