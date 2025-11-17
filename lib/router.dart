import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_state.dart';
import 'pages/catalog_item_page.dart';
import 'pages/catalog_page.dart';
import 'pages/detail_page.dart';
import 'pages/dialog_page.dart';
import 'pages/error_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';
import 'widgets/app_scaffold.dart';

GoRouter createRouter(AppState appState) {
  return GoRouter(
    initialLocation: '/home',
    refreshListenable: appState,
    errorBuilder: (context, state) => ErrorPage(
      message: state.error?.toString() ?? '未知错误',
      location: state.uri.toString(),
    ),
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppScaffold(navigationShell: navigationShell, appState: appState),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => HomePage(appState: appState),
                routes: [
                  GoRoute(
                    path: 'details/:id',
                    name: 'home-details',
                    builder: (context, state) => DetailPage(
                      id: state.pathParameters['id']!,
                      from: state.uri.queryParameters['from'],
                    ),
                  ),
                  GoRoute(
                    path: 'modal',
                    name: 'home-modal',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      barrierDismissible: true,
                      opaque: false,
                      barrierColor: Colors.black54,
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                      child: const DialogPage(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/catalog',
                name: 'catalog',
                builder: (context, state) => const CatalogPage(),
                routes: [
                  GoRoute(
                    path: 'item/:id',
                    name: 'catalog-item',
                    builder: (context, state) => CatalogItemPage(
                      id: state.pathParameters['id']!,
                      highlighted:
                          state.uri.queryParameters['highlighted'] == 'true',
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                name: 'settings',
                builder: (context, state) => SettingsPage(appState: appState),
                routes: [
                  GoRoute(
                    path: 'profile',
                    name: 'profile',
                    builder: (context, state) =>
                        ProfilePage(appState: appState),
                    redirect: (context, state) {
                      if (!appState.isLoggedIn) {
                        final target = Uri.encodeComponent(
                          state.uri.toString(),
                        );
                        return '/login?from=$target';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginPage(
          appState: appState,
          redirectTo: state.uri.queryParameters['from'],
        ),
      ),
    ],
  );
}
