import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media_app/app/data/enum/enum.dart';
import 'package:social_media_app/app/data/models/user_model.dart';
import 'package:social_media_app/app/data/repositories/post_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../data/models/post_model.dart';
import '../services/database_service.dart';
import '../ui/widgets/trime.dart';

class PostCreateController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final Trimmer trimmer = Trimmer();
  var selectedFiles = RxList<XFile>([]);
  var isLoading = false.obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);
  Rx<PostType> postType = PostType.text.obs;
  final TextEditingController captionController = TextEditingController();


  void compressAndSetVideo(String path) async {
    Get.defaultDialog(title: 'Compressing video', content: Text('Path: $path'));

    // Check if file exists
    final file = File(path);
    if (!file.existsSync()) {
      Get.snackbar('Error', 'File does not exist at the provided path.');
      return;
    }

    // Log the start of compression
    print('Starting video compression for: $path');

    try {
      final MediaInfo? mediaInfo = await VideoCompress.compressVideo(
        path,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false, // Don't delete the original file
        includeAudio: true,
      );

      // Log the media info
      print('Compression complete: $mediaInfo');

      if (mediaInfo != null && mediaInfo.path != null) {
        selectedFiles.value = [XFile(mediaInfo.path!)];
        Get.snackbar('Success', 'Video compressed successfully.');
      } else {
        Get.snackbar('Error', 'Video compression failed. MediaInfo is null.');
      }
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Video compression failed: $e');
      Get.back();
      print('Error during video compression: $e');
    }
  }
  Future<bool> requestPermissions() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      Get.snackbar('Permission Denied', 'Storage permission is required to compress video.');
      return false;
    }
  }
  PostRepository postRepository = ServiceLocator.postRepository;

  Future<void> getUser() async {
    user.value = await ServiceLocator.userRepository.getUser();
    print(user.value!.email);
  }

  final TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void selectFiles(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a Photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
                  selectedFiles.value = pickedFiles;
                  postType.value = PostType.image;
                                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    selectedFiles.value = [pickedFile];
                    postType.value = PostType.image;
                  }
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Record a Video'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  XFile? pickedFile = await ImagePicker().pickVideo(source: ImageSource.camera);
                  if (pickedFile != null) {
                    selectedFiles.value = [pickedFile];
                    postType.value = PostType.video;
                  }
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose Video from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  XFile? pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    postType.value = PostType.video;
                    await trimmer.loadVideo(videoFile: File(pickedFile.path));
                    final duration = await VideoCompress.getMediaInfo(pickedFile.path);

                    if (duration.duration! > 45) {
                      Get.to(() => TrimmerView(File(pickedFile.path)));
                    } else {
                      compressAndSetVideo(pickedFile.path);
                    }
                  }
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void clearSelectedFiles() {
    selectedFiles.clear();
    postType.value = PostType.text;
  }

  void uploadPost() async {
    isLoading.value = true;
    try {
      List<String> content = [];

      if (postType.value == PostType.text) {
        content = [captionController.text];
      } else {
        content = await Future.wait(selectedFiles.map((file) => uploadFile(file, postType.value)));
        // // Upload the files first
        // for (var file in selectedFiles) {
        //   String? fileUrl = await uploadFile(file, postType.value);
        //   content.add(fileUrl!);
        // }
      }
      await Future.delayed(const Duration(seconds: 2));
      String postId = const Uuid().v4();
      String res = await postRepository.savePost(Post(
        postId: postId,
        uid: user.value!.uid,
        username: user.value!.username,
        profilePicUrl: user.value!.profilePicUrl,
        content: content,
        caption: captionController.text,
        likes: [],
        comments: [],
        createdAt: DateTime.now(),
        postTypeIndex: postType.value.index,
        privacy: 'public',
      ));

      if (res == 'Saved') {
        Get.snackbar('Success', 'Posted successfully');
        clearSelectedFiles();
        captionController.clear();
      } else {
        Get.snackbar('Error', res);
      }
    } catch (err) {
      Get.snackbar('Error', err.toString());
    } finally {
      isLoading.value = false;
    }
    Get.back();
  }

  Future<String> uploadFile(XFile file, PostType type) async {
    String downloadUrl='';
    if(type==PostType.video){
       downloadUrl = await ServiceLocator.storageRepository.uploadFile(File(file.path), 'users/${user.value!.uid}/posts', 'videos');
    }else if(type==PostType.image){
      downloadUrl = await ServiceLocator.storageRepository.uploadFile(File(file.path), 'users/${user.value!.uid}/posts', 'image');
    }
    await Future.delayed(Duration(seconds: 2));
    return downloadUrl;
  }

  @override
  void onClose() {
    super.onClose();
    descriptionController.dispose();
  }
}
