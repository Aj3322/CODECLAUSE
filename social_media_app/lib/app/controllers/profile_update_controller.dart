import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/app/controllers/home_controller.dart';
import 'package:social_media_app/app/data/repositories/storage_repo.dart';
import 'package:social_media_app/app/data/repositories/user_repository.dart';
import 'package:social_media_app/app/services/database_service.dart';
import 'package:social_media_app/app/ui/pages/home/home_view.dart';
import '../data/models/user_model.dart';
import 'dart:io';
import 'package:path/path.dart';
class ProfileUpdateController extends GetxController {
  final StorageRepo storageRepository = ServiceLocator.storageRepository;
  final UserRepository userRepository = ServiceLocator.userRepository;

  final userModel = Rxn<UserModel>();

  // TextEditingControllers for form fields
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  final contactNumberController = TextEditingController();
  final locationController = TextEditingController();
  final websiteController = TextEditingController();
  final birthdateController = TextEditingController();
  final genderController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  void loadUserProfile() async {
    final user = await userRepository.getUser(id:FirebaseAuth.instance.currentUser!.uid);
    if (user != null) {
      userModel.value = user;
      usernameController.text = user.username;
      emailController.text = user.email;
      bioController.text = user.bio;
      contactNumberController.text = user.contactNumber ?? '';
      locationController.text = user.location ?? '';
      websiteController.text = user.website ?? '';
      birthdateController.text = user.birthdate?.toIso8601String() ?? '';
      genderController.text = user.gender ?? '';
    }
  }

  Future<void> picImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      String? downloadUrl = await storageRepository.uploadFile(file, 'users/${userModel.value!.uid}/profile','profileImage.jpg');

      if (downloadUrl != null) {
        userModel.value = userModel.value!.copyWith(profilePicUrl: downloadUrl);
        // await userRepository.updateUser(userModel.value!);
      }
    } else {
      print('No image selected.');
    }
  }

  void updateUserProfile() async {
    if (userModel.value != null) {
      UserModel updatedUser = userModel.value!.copyWith(
        username: usernameController.text,
        email: emailController.text,
        bio: bioController.text,
        contactNumber: contactNumberController.text,
        location: locationController.text,
        website: websiteController.text,
        birthdate: birthdateController.text.isNotEmpty ? DateTime.parse(birthdateController.text) : null,
        gender: genderController.text,
      );

      await ServiceLocator.userRepository.updateUser(updatedUser);
      Get.find<HomeController>().getUser();
      Get.back(); // Close the profile update page
    }
  }
}
