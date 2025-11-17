# go_router 导航方法速查

此文档整理 go_router 中常用的导航方法及其使用场景，帮助快速进行查阅。

| 方法 | 说明 | 是否保留当前页面 | 支持路径参数 | 支持查询参数 |
|------|------|------------------|--------------|--------------|
| `context.go(String location, {Object? extra})` | 跳转到目标路径，替换当前路由栈 | 否 | 是 | 是 |
| `context.goNamed(String name, {Map<String, String> pathParameters = const {}, Map<String, String> queryParameters = const {}, Object? extra})` | 通过路由名称跳转 | 否 | 是 | 是 |
| `context.push(String location, {Object? extra})` | 将新路由压入栈顶 | 是 | 是 | 是 |
| `context.pushNamed(String name, {Map<String, String> pathParameters = const {}, Map<String, String> queryParameters = const {}, Object? extra})` | 通过名称压栈 | 是 | 是 | 是 |
| `context.replace(String location, {Object? extra})` | 替换当前路由 | 否（替换） | 是 | 是 |
| `context.replaceNamed(String name, {Map<String, String> pathParameters = const {}, Map<String, String> queryParameters = const {}, Object? extra})` | 通过名称替换当前路由 | 否（替换） | 是 | 是 |
| `context.pop()` | 关闭当前页面返回上一层 | - | - | - |
| `context.pop<T extends Object?>([T? result])` | 返回上一层并携带结果 | - | - | - |
| `context.canPop()` | 是否可以返回（堆栈是否大于 1） | - | - | - |

## 使用示例

### 基础跳转

```dart
TextButton(
  onPressed: () => context.go('/settings'),
  child: const Text('Go to Settings'),
);
```

### 名称跳转

```dart
TextButton(
  onPressed: () => context.goNamed('profile', pathParameters: {'id': '42'}),
  child: const Text('View Profile'),
);
```

### 压栈导航

```dart
TextButton(
  onPressed: () => context.push('/details/101'),
  child: const Text('Open Details'),
);
```

### 替换当前路由

```dart
TextButton(
  onPressed: () => context.replace('/login'),
  child: const Text('Back to Login'),
);
```

### 返回并携带结果

```dart
TextButton(
  onPressed: () => context.pop('result from child'),
  child: const Text('Return Result'),
);
```

## 导航扩展

- `GoRouter.of(context)`：直接获取 `GoRouter` 实例
- `GoRouter.of(context).refresh()`：手动触发路由刷新
- `GoRouter.of(context).location`：获取当前路由地址
- `GoRouter.of(context).routerDelegate`：访问底层 RouterDelegate

> 提示：在进行复杂导航操作时，请确保路由名称、路径参数和查询参数与路由配置一致。
