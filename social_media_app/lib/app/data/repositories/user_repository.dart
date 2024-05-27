import 'dart:io';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../providers/local_provider.dart';
import '../providers/remote_provider.dart';

class UserRepository {
  UserRepository._privateConstructor() {
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        userModel = null;
      } else {
        _initializeUserModel(user.uid);
      }
    });
  }

  static final UserRepository _instance = UserRepository._privateConstructor();

  factory UserRepository() {
    return _instance;
  }

  UserModel? userModel;
  bool _initialized = false;
  final LocalProvider _localProvider = LocalProvider();
  final RemoteProvider _remoteProvider = RemoteProvider();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> initialize() async {
    if (!_initialized) {
      await _initializeUserModel(FirebaseAuth.instance.currentUser?.uid);
      _initialized = true;
    }
  }

  Future<void> _initializeUserModel(String? uid) async {
    if (uid != null) {
      userModel = await getUser(id: uid);
    }
  }

  Future<void> saveUser(UserModel user) async {
    try {
      await _localProvider.saveUser(user);
      await _remoteProvider.saveUser(user);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<UserModel?> getUser({String id = ''}) async {
    if (id.isEmpty) {
      id = FirebaseAuth.instance.currentUser?.uid ?? '';
    }
    if (id.isNotEmpty) {
      print("id $id");
      return _remoteProvider.getUser(id);
    }
    return null;
  }

  Future<List<UserModel>> searchUsersByUsernameOrEmail(String query) {
    return _remoteProvider.searchUsersByUsernameOrEmail(query);
  }

  Future<List<UserModel>> fetchTopUsers() {
    return _remoteProvider.fetchTopUsers();
  }

  Future<void> followUser(UserModel userModel) {
    return _remoteProvider.followUser(userModel).then((value) => _initializeUserModel(FirebaseAuth.instance.currentUser?.uid));
  }
  Future<void> unFollowUser(UserModel userModel) {
    return _remoteProvider.unFollowUser(userModel).then((value) => _initializeUserModel(FirebaseAuth.instance.currentUser?.uid));
  }

  Stream<UserModel> userStream(String id) {
    return _remoteProvider.userStream(id);
  }

  Future<void> deleteUser(String userId) async {
    await _localProvider.deleteUser(userId);
  }

  Future<void> updateUser(UserModel updatedUser) async {
    await _remoteProvider.updateUser(updatedUser);
    await _localProvider.updateUser(updatedUser);
    _initializeUserModel(FirebaseAuth.instance.currentUser?.uid);
  }

  Future<void> addUserToChat(String receiverId,String senderId) async {
   await _remoteProvider.addUserToChat(receiverId,senderId);
  }
}
