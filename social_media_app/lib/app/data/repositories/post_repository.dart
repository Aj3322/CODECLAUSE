import 'package:get/get.dart';
import '../models/post_model.dart';
import '../providers/local_provider.dart';
import '../providers/remote_provider.dart';

class PostRepository {
  PostRepository._privateConstructor();

  static final PostRepository _instance = PostRepository._privateConstructor();

  factory PostRepository() {
    return _instance;
  }


  final LocalProvider _localProvider = LocalProvider();
  final RemoteProvider _remoteProvider = RemoteProvider();

  Future<String> savePost(Post post) async {
    String res='';
    try {
      await _localProvider.savePost(post);
      res = 'Saved';
    }catch(e){
      return e.toString();
    }
    try {
      await _remoteProvider.savePost(post);
      res = 'Saved';
    }catch(e){
      res=e.toString();
    }
   return res;
  }

  Future<void> deletePost(String postId) async {
    await _localProvider.deletePost(postId);
    await _remoteProvider.deletePost(postId);
  }

  Future<void> updatePost(Post post) async {
    await _localProvider.updatePost(post);
    await _remoteProvider.updatePost(post);
  }

  Future<void> likePost(Post post) async {
    await _localProvider.updatePost(post);
    await _remoteProvider.likePost(post);

  }

  Future<Post> getPosts(String postId) {
    return _remoteProvider.getPostByPostId(postId);
  }

  Stream<List<Post>> postStream() {
    return _remoteProvider.getPosts();
  }
  Stream<List<Post>> postStreamByUserId(String userId) {
    return _remoteProvider.getPostsByUserId(userId);
  }

  Future<void> syncPosts() async {
    List<Post> posts = await _remoteProvider.getPosts().first;
    for (Post post in posts) {
      await _localProvider.savePost(post);
    }
  }
}
