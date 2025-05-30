import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:protekno/screens/user_list_screen.dart';
import 'screens/home_screen.dart';
import 'screens/post_detail_screen.dart';
import 'screens/user_posts_screen.dart';
import 'screens/post_edit_screen.dart';
import 'screens/post_create_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          path: 'users',
          name: 'users',
          builder: (context, state) => UsersScreen(),
        ),
        GoRoute(
          path: 'post/:postId',
          name: 'postDetail',
          builder: (context, state) {
            final postId = int.tryParse(state.pathParameters['postId'] ?? '');
            if (postId == null) return const Scaffold(body: Center(child: Text('Invalid post ID')));
            return PostDetailScreen(postId: postId);
          },
          routes: [
            GoRoute(
              path: 'edit',
              name: 'postEdit',
              builder: (context, state) {
                final postId = int.tryParse(state.pathParameters['postId'] ?? '');
                if (postId == null) return const Scaffold(body: Center(child: Text('Invalid post ID')));
                return PostEditScreen(postId: postId);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'user/:userId/posts',
          name: 'userPosts',
          builder: (context, state) {
            final userId = int.tryParse(state.pathParameters['userId'] ?? '');
            if (userId == null) return const Scaffold(body: Center(child: Text('Invalid user ID')));
            return UserPostsScreen(userId: userId, userName: '');
          },
        ),
        GoRoute(
          path: 'post/create',
          name: 'postCreate',
          builder: (context, state) => PostCreateScreen(),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Social App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
