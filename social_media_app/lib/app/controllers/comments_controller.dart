import 'package:get/get.dart';
import 'package:social_media_app/app/data/models/comment_model.dart';
import 'package:social_media_app/app/data/models/notfication_model.dart';
import 'package:social_media_app/app/data/models/user_model.dart';
import 'package:social_media_app/app/data/repositories/comment_repository.dart';
import 'package:social_media_app/app/data/repositories/notification_repository.dart';
import 'package:social_media_app/app/services/database_service.dart';
import 'package:uuid/uuid.dart';

import '../data/models/post_model.dart';

class CommentsController extends GetxController {
  CommentRepository commentRepository = ServiceLocator.commentRepository;
  NotificationRepository notificationRepository =
      ServiceLocator.notificationRepository;
  Rx<UserModel> userModel = ServiceLocator.userRepository.userModel!.obs;
  Stream<List<CommentModel>> getComments(String postId) {
    return commentRepository.getCommentsForPost(postId);
  }

  void postComment(CommentModel commentModel) async {
    try {
      commentRepository.addComment(commentModel);
      Post post = await ServiceLocator.postRepository.getPosts(commentModel.postId);
      notificationRepository.sendNotification(NotificationModel(
          notificationId: const Uuid().v4(),
          userId: post.uid,
          content: commentModel.content,
          postContent: post.content.first,
          postId: post.postId,
          postType: post.postType.name,
          timestamp: DateTime.now(),
          seen: false,
          type: 'comment',
          senderId: commentModel.userId));
    } catch (err) {
      print(err);
      Get.snackbar('Error', err.toString());
    }
  }
}
