import 'package:protekno/service/api_service';

import '../models/comment_model.dart';

class CommentRepository {
  final ApiService api;

  CommentRepository(this.api);

  Future<List<Comment>> getCommentsByPostId(int postId) => api.getCommentsByPostId(postId);
  Future<void> addComment(Comment comment) => api.addComment(comment);
}
