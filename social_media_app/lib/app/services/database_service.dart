import 'package:social_media_app/app/data/repositories/comment_repository.dart';
import 'package:social_media_app/app/data/repositories/message_repository.dart';
import 'package:social_media_app/app/data/repositories/post_repository.dart';
import 'package:social_media_app/app/data/repositories/storage_repo.dart';

import '../data/models/message_model.dart';
import '../data/models/notfication_model.dart';
import '../data/models/post_model.dart';
import '../data/models/user_model.dart';
import '../data/repositories/user_repository.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class ServiceLocator {
  static final UserRepository userRepository = UserRepository();
  static final StorageRepo storageRepository = StorageRepo();
  static final PostRepository postRepository = PostRepository();
  static final CommentRepository commentRepository = CommentRepository();
  static final ChatRepository chatRepository = ChatRepository();
}


class LocalDatabaseService {
  static const String _userBox = 'userBox';
  static const String _postBox = 'postBox';
  static const String _notificationBox = 'notificationBox';
  static const String _messageBox = 'messageBox';

  static final LocalDatabaseService _instance = LocalDatabaseService._internal();

  factory LocalDatabaseService() {
    return _instance;
  }

  LocalDatabaseService._internal();

  Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(PostAdapter());
    Hive.registerAdapter(NotificationModelAdapter());
    Hive.registerAdapter(MessageModelAdapter());

    // Open boxes
    await Hive.openBox<UserModel>(_userBox);
    await Hive.openBox<Post>(_postBox);
    await Hive.openBox<NotificationModel>(_notificationBox);
    await Hive.openBox<MessageModel>(_messageBox);
    ServiceLocator.userRepository;
  }

  Box<UserModel> get userBox => Hive.box<UserModel>(_userBox);
  Box<Post> get postBox => Hive.box<Post>(_postBox);
  Box<NotificationModel> get notificationBox => Hive.box<NotificationModel>(_notificationBox);
  Box<MessageModel> get messageBox => Hive.box<MessageModel>(_messageBox);

  Future<void> clearAllBoxes() async {
    await userBox.clear();
    await postBox.clear();
    await notificationBox.clear();
    await messageBox.clear();
  }
}
