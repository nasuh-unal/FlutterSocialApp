import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protekno/models/post_model.dart';
import 'package:protekno/repositories/comment_repository.dart';
import 'package:protekno/repositories/post_repository.dart';
import 'package:protekno/repositories/user_repository.dart';
import 'package:protekno/service/api_service';


final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final postRepositoryProvider = Provider<PostRepository>((ref) => PostRepository(ref.read(apiServiceProvider)));
final userRepositoryProvider = Provider<UserRepository>((ref) => UserRepository(ref.read(apiServiceProvider)));
final commentRepositoryProvider = Provider<CommentRepository>((ref) => CommentRepository(ref.read(apiServiceProvider)));

final postsProvider = FutureProvider((ref) => ref.read(postRepositoryProvider).getPosts());
final usersProvider = FutureProvider((ref) => ref.read(userRepositoryProvider).getUsers());
final userPostsProvider = FutureProvider.family<List<Post>, int>((ref, userId) {
  return ref.read(postRepositoryProvider).getPostsByUser(userId);
});

