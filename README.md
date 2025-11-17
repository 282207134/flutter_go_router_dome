# Go Router 学习示例项目

一个完整的 Flutter go_router 学习项目，包含详细的中文文档和可运行的示例代码。

## 📚 项目简介

这是一个专门为学习 Flutter go_router 包而创建的示例项目。项目包含：

- ✅ 完整的 go_router 功能演示
- ✅ 详细的中文文档
- ✅ 可直接运行的示例代码
- ✅ 涵盖基础到高级的各种用法

## 🚀 快速开始

> 更详细的操作步骤可参考 [QUICK_START.md](QUICK_START.md)

### 安装依赖

```bash
flutter pub get
```

### 运行项目

```bash
# 在 Chrome 上运行（推荐用于学习）
flutter run -d chrome

# 在其他平台运行
flutter run -d macos    # macOS
flutter run -d windows  # Windows
flutter run             # 移动设备
```

## 📖 文档目录

项目包含了全面的中文文档，位于 `docs/` 目录：

1. **[01_go_router_基础概念.md](docs/01_go_router_基础概念.md)**
   - go_router 是什么
   - 主要特性
   - 核心概念
   - 与传统 Navigator 的区别

2. **[02_go_router_导航方法速查.md](docs/02_go_router_导航方法速查.md)**
   - 所有导航方法的速查表
   - 使用示例
   - 参数说明

3. **[03_路由配置详解.md](docs/03_路由配置详解.md)**
   - GoRoute 参数详解
   - 路径定义规则
   - GoRouterState 使用
   - 自定义转场动画

4. **[04_重定向与守卫.md](docs/04_重定向与守卫.md)**
   - 全局重定向
   - 路由级别守卫
   - 权限控制实现
   - refreshListenable 使用

5. **[05_嵌套路由与Shell.md](docs/05_嵌套路由与Shell.md)**
   - 嵌套路由
   - ShellRoute
   - StatefulShellRoute
   - 底部导航栏实现

6. **[06_常见问题与最佳实践.md](docs/06_常见问题与最佳实践.md)**
   - 常见问题解答
   - 最佳实践建议
   - 性能优化技巧

7. **[07_代码示例集锦.md](docs/07_代码示例集锦.md)**
   - 常见代码片段
   - ShellRoute/StatefulShellRoute 实践
   - 自定义转场动画示例

## 🎯 功能演示

### 1. 基础导航

项目演示了所有常用的导航方法：

- `context.go()` - 跳转并替换
- `context.push()` - 压栈导航
- `context.pop()` - 返回上一页
- `context.replace()` - 替换当前路由
- `context.goNamed()` / `context.pushNamed()` - 命名路由导航

### 2. 参数传递

演示了三种参数传递方式：

- **路径参数**: `/user/:id`
- **查询参数**: `/search?keyword=flutter&category=tutorial`
- **Extra 参数**: `context.push('/details', extra: data)`

### 3. 路由守卫

演示如何实现登录拦截和权限控制：

- 全局重定向
- 路由级别的 redirect
- 使用 refreshListenable 响应状态变化

### 4. StatefulShellRoute

演示使用 `StatefulShellRoute` 实现底部导航栏，并保持每个标签页的状态。

### 5. 自定义转场动画

演示如何使用 `CustomTransitionPage` 实现自定义页面转场效果。

## 🏗️ 项目结构

```
go_router_learning/
├── docs/                          # 文档目录
│   ├── 01_go_router_基础概念.md
│   ├── 02_go_router_导航方法速查.md
│   ├── 03_路由配置详解.md
│   ├── 04_重定向与守卫.md
│   ├── 05_嵌套路由与Shell.md
│   ├── 06_常见问题与最佳实践.md
│   └── 07_代码示例集锦.md
├── lib/
│   ├── main.dart                  # 应用入口
│   ├── app_state.dart            # 全局状态管理
│   ├── router.dart               # 路由配置
│   ├── pages/                    # 页面
│   │   ├── home_page.dart
│   │   ├── catalog_page.dart
│   │   ├── catalog_item_page.dart
│   │   ├── detail_page.dart
│   │   ├── dialog_page.dart
│   │   ├── login_page.dart
│   │   ├── profile_page.dart
│   │   ├── settings_page.dart
│   │   └── error_page.dart
│   └── widgets/                  # 公共组件
│       └── app_scaffold.dart
├── pubspec.yaml
└── README.md
```

## 💡 学习路径建议

1. **阅读文档** (30分钟)
   - 从 `docs/01_go_router_基础概念.md` 开始
   - 按顺序阅读所有文档

2. **运行项目** (10分钟)
   - 启动项目并浏览各个页面
   - 观察 URL 的变化

3. **代码学习** (1-2小时)
   - 阅读 `lib/router.dart` 了解路由配置
   - 查看各个页面的实现
   - 尝试修改代码观察效果

4. **实践练习**
   - 添加新的路由
   - 实现自定义的导航逻辑
   - 尝试不同的转场动画

## 🔑 核心代码示例

### 路由配置

```dart
final router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => AppScaffold(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => HomePage(),
            ),
          ],
        ),
        // 更多分支...
      ],
    ),
  ],
);
```

### 导航使用

```dart
// 基础导航
context.go('/settings');

// 命名路由 + 参数
context.pushNamed(
  'catalog-item',
  pathParameters: {'id': '101'},
  queryParameters: {'highlighted': 'true'},
);

// 携带额外数据
context.push('/details', extra: myData);

// 返回上一页
context.pop();
```

### 路由守卫

```dart
GoRoute(
  path: '/profile',
  name: 'profile',
  builder: (context, state) => ProfilePage(),
  redirect: (context, state) {
    if (!appState.isLoggedIn) {
      return '/login?from=${Uri.encodeComponent(state.uri.toString())}';
    }
    return null;
  },
)
```

## 📦 依赖项

```yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^14.1.4
  cupertino_icons: ^1.0.8
```

## 🎨 特性亮点

- ✨ Material 3 设计
- 🌐 支持 Web、移动端、桌面端
- 🔄 状态保持（StatefulShellRoute）
- 🎭 自定义转场动画
- 🔐 登录守卫演示
- 📱 底部导航栏
- 🎯 命名路由
- 📎 多种参数传递方式

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

## 🙏 致谢

- Flutter 团队开发的 go_router 包
- Flutter 中文社区的支持

## 📞 联系方式

如有问题或建议，欢迎通过以下方式联系：

- 提交 Issue
- Pull Request

---

Happy Learning! 🎉
