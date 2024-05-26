
import 'package:social_media_app/app/data/repositories/user_repository.dart';

import '../models/comment_model.dart';
import '../providers/remote_provider.dart';

class CommentRepository {
  final RemoteProvider _remoteProvider = RemoteProvider();
  CommentRepository._privateConstructor();
  static final CommentRepository _instance = CommentRepository._privateConstructor();

  factory CommentRepository() {
    return _instance;
  }

  Future<void> addComment(CommentModel comment) async {
    await _remoteProvider.addComment(comment);
  }

  Stream<List<CommentModel>> getCommentsForPost(String postId) {
    return _remoteProvider.getCommentsForPost(postId);
  }

  Future<void> deleteComment(String commentId,String postId) async {
    await _remoteProvider.deleteComment(commentId,postId);
  }

  Future<void> updateComment(CommentModel updatedComment) async {
    await _remoteProvider.updateComment(updatedComment);
  }
}
