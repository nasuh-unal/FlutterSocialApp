import 'package:protekno/service/api_service';

import '../models/post_model.dart';

class PostRepository {
  final ApiService api;

  PostRepository(this.api);

  Future<List<Post>> getPosts() => api.getPosts();
  Future<Post> getPostById(int id) => api.getPostById(id);
  Future<List<Post>> getPostsByUser(int userId) => api.getPostsByUser(userId);
  Future<void> createPost(Post post) => api.createPost(post);
  Future<void> updatePost(Post post) => api.updatePost(post);
  Future<void> deletePost(int id) => api.deletePost(id);
}
