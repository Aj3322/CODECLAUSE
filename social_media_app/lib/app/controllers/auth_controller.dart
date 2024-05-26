import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_app/app/data/models/user_model.dart' as user;
import 'package:social_media_app/app/services/database_service.dart';

import '../data/repositories/user_repository.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UserRepository userRepository = UserRepository();
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print('Data $googleUser');
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      Get.offNamed(Routes.HOME);
    } catch (error) {
      Get.snackbar('Error', 'Failed to sign in with Google: $error');
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print('Data =======  $googleUser');
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }
      print('Hii++++++++++++++++++++++++++++4555555555555++++++++++++++++++++++++++data save');
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print('Hii++++++++++++++++++++++++++4444444444444444444++++++++++++++++++++++++++++data save');
      // Check if the user already exists
      final userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.additionalUserInfo!.isNewUser) {
        print('Hii++++++++++++++++++++++++++++++++++++++++++++++++++++++data save');
        // Perform additional actions for new user sign-up, e.g., save user data to database
        // userRepository.saveUser(user.UserModel(
        //     uid: _auth.currentUser!.uid,
        //     username: userCredential.additionalUserInfo!.username!,
        //     email: googleUser.email,
        //     profilePicUrl: googleUser.photoUrl!,
        //     bio: '',
        //     followers: [],
        //     following: [],
        //     posts: [],
        //     createdAt: DateTime.now(),
        //     lastActiveAt: DateTime.now(),
        //     isVerified: false));
        print('Hii++++++++++++++++++++++++++++++++++++++++++++++++++++++data save');
        // ServiceLocator.userRepository.initialize();
        Get.offNamed(Routes.HOME);

      }

      // Navigate to home screen or perform any other action upon successful sign-up/sign-in

    } catch (error) {
      Get.snackbar('Error', 'Failed to sign in with Google: $error');
      print('Errror in SignUp ========               $error');
      // Handle sign-up error
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

     await ServiceLocator.userRepository.saveUser(user.UserModel(
          uid: _auth.currentUser!.uid,
          username: name,
          email: email,
          profilePicUrl: 'https://firebasestorage.googleapis.com/v0/b/socialcircle-e9a40.appspot.com/o/fashion-boy-with-yellow-jacket-blue-pants.jpg?alt=media&token=c8a81567-335a-434e-96a5-c86e8ccdd96d',
          bio: '',
          followers: [],
          following: [],
          posts: [],
          createdAt: DateTime.now(),
          lastActiveAt: DateTime.now(),
          isVerified: false));


      // Sign up successful
      // ServiceLocator.userRepository.initialize();
      Get.snackbar('Success', 'Sign up successful');
      Get.offNamed(Routes.HOME);
    } catch (error) {
      // Handle sign up errors
      Get.snackbar('Error', error.toString());
      print(error.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Sign up successful
      // ServiceLocator.userRepository.initialize();
      Get.snackbar('Success', 'Sign In successful : ${_auth.currentUser!.uid}');
      Get.offNamed(Routes.HOME);

    } catch (error) {
      // Handle sign up errors
      Get.snackbar('Error', error.toString());
    }
  }
}
