import 'package:get/get.dart';
import 'package:social_media_app/app/data/models/comment_model.dart';
import 'package:social_media_app/app/data/models/user_model.dart';
import 'package:social_media_app/app/data/repositories/comment_repository.dart';
import 'package:social_media_app/app/services/database_service.dart';

class CommentsController extends GetxController {

  CommentRepository commentRepository = ServiceLocator.commentRepository;
  Rx<UserModel> userModel = ServiceLocator.userRepository.userModel!.obs;
  Stream<List<CommentModel>> getComments(String postId){
    return commentRepository.getCommentsForPost(postId);
  }

  void postComment(CommentModel commentModel) async {
    try {
        commentRepository.addComment(commentModel);
    } catch (err) {
      print(err);
      Get.snackbar('Error', err.toString());
    }
  }


}
