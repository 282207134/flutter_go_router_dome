import 'package:flutter_test/flutter_test.dart';

import 'package:go_router_learning/main.dart';

void main() {
  testWidgets('加载首页时展示项目标题', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Go Router 学习项目'), findsOneWidget);
  });
}
