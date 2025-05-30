import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protekno/providers/providers.dart';
import 'post_detail_screen.dart';

class UserPostsScreen extends ConsumerWidget {
  final int userId;
  final String userName;

  const UserPostsScreen({Key? key, required this.userId, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPostsAsync = ref.watch(userPostsProvider(userId));

    return Scaffold(
      appBar: AppBar(title: Text('$userName\'in Gönderileri')),
      body: userPostsAsync.when(
        data: (posts) => ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return ListTile(
              title: Text(post.title),
              subtitle: Text(post.body.length > 50 ? '${post.body.substring(0, 50)}...' : post.body),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PostDetailScreen(postId: post.id)),
                );
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Hata: $e')),
      ),
    );
  }
}
