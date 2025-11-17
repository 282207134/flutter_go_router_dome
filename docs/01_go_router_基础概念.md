# go_router 基础概念

## 什么是 go_router？

go_router 是 Flutter 官方推荐的声明式路由包，它提供了一种简洁、类型安全的方式来处理应用程序的导航。

## 主要特性

1. **声明式路由配置**：使用声明式的方式定义所有路由
2. **深度链接支持**：原生支持 Web URL 和移动应用深度链接
3. **类型安全**：通过类型参数传递数据，减少运行时错误
4. **嵌套路由**：支持复杂的路由嵌套结构
5. **重定向和守卫**：支持路由重定向和权限守卫
6. **错误处理**：优雅的错误页面处理

## 核心概念

### 1. GoRouter

`GoRouter` 是路由器的主要类，负责管理所有的路由配置和导航逻辑。

```dart
final router = GoRouter(
  routes: [
    // 路由定义
  ],
);
```

### 2. GoRoute

`GoRoute` 定义单个路由，包括路径、页面构建器、子路由等。

```dart
GoRoute(
  path: '/home',
  name: 'home',
  builder: (context, state) => HomePage(),
)
```

### 3. 路径参数

通过 `:参数名` 的形式定义动态路径参数：

```dart
GoRoute(
  path: '/user/:id',
  builder: (context, state) {
    final id = state.pathParameters['id'];
    return UserPage(userId: id);
  },
)
```

### 4. 查询参数

通过 `state.uri.queryParameters` 获取查询参数：

```dart
// URL: /search?keyword=flutter
final keyword = state.uri.queryParameters['keyword'];
```

### 5. 导航方法

- `context.go('/path')` - 导航到新路由（不保留当前页面）
- `context.push('/path')` - 推送新路由到堆栈
- `context.pop()` - 返回上一页
- `context.replace('/path')` - 替换当前路由

## 与传统 Navigator 的区别

| 特性 | Navigator | go_router |
|-----|-----------|-----------|
| 配置方式 | 命令式 | 声明式 |
| URL 支持 | 需要额外配置 | 原生支持 |
| 深度链接 | 复杂 | 简单 |
| 类型安全 | 弱 | 强 |
| 嵌套路由 | 复杂 | 简单 |

## 基本使用流程

1. 在 `pubspec.yaml` 中添加依赖
2. 创建 `GoRouter` 实例并定义路由
3. 使用 `MaterialApp.router` 代替 `MaterialApp`
4. 使用 `context.go()` 等方法进行导航
