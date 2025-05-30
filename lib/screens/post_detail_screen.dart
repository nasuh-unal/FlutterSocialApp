import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/post_model.dart';
import '../models/comment_model.dart';
import '../providers/providers.dart';

final postDetailProvider = FutureProvider.family<Post, int>((ref, postId) {
  return ref.read(postRepositoryProvider).getPostById(postId);
});

final commentsProvider = FutureProvider.family<List<Comment>, int>((ref, postId) {
  return ref.read(commentRepositoryProvider).getCommentsByPostId(postId);
});

class PostDetailScreen extends ConsumerWidget {
  final int postId;

  PostDetailScreen({required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postAsync = ref.watch(postDetailProvider(postId));
    final commentsAsync = ref.watch(commentsProvider(postId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Gönderi Detayı'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              context.push('/post/$postId/edit');
            },
          ),
        ],
      ),
      body: postAsync.when(
        data: (post) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.title, style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 8),
                Text(post.body),
                SizedBox(height: 20),
                Text('Yorumlar:', style: Theme.of(context).textTheme.titleMedium),
                commentsAsync.when(
                  data: (comments) => ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: comments.length,
                    separatorBuilder: (_, __) => Divider(),
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return ListTile(
                        title: Text(comment.name),
                        subtitle: Text(comment.body),
                      );
                    },
                  ),
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Yorumlar yüklenemedi: $e'),
                )
              ],
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Gönderi yüklenemedi: $error')),
      ),
    );
  }
}
