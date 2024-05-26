import 'package:hive/hive.dart';
import 'package:social_media_app/app/data/providers/remote_provider.dart';
import '../models/notfication_model.dart';
import '../models/user_model.dart';
import '../models/post_model.dart';
import '../models/message_model.dart';

class LocalProvider {

  LocalProvider._privateConstructor();

  static final LocalProvider _instance = LocalProvider._privateConstructor();

  factory LocalProvider() {
    return _instance;
  }


  static const String _userBox = 'userBox';
  static const String _postBox = 'postBox';
  static const String _notificationBox = 'notificationBox';
  static const String _messageBox = 'messageBox';

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(PostAdapter());
    Hive.registerAdapter(NotificationModelAdapter());
    Hive.registerAdapter(MessageModelAdapter());

    await Hive.openBox<UserModel>(_userBox);
    await Hive.openBox<Post>(_postBox);
    await Hive.openBox<NotificationModel>(_notificationBox);
    await Hive.openBox<MessageModel>(_messageBox);
  }

  // User methods
  Future<void> saveUser(UserModel user) async {
    final box = Hive.box<UserModel>(_userBox);
    await box.put(user.uid, user);
  }

  UserModel? getUser(String id) {
    final box = Hive.box<UserModel>(_userBox);
    return box.get(id);
  }
  Future<void> updateUser(UserModel updatedUser) async {
    final box = Hive.box<UserModel>(_userBox);
    await box.put(updatedUser.uid, updatedUser);
  }

  Future<void> deleteUser(String userId) async {
    final box = Hive.box<UserModel>(_userBox);
    await box.delete(userId);
  }

  // Post methods
  Future<void> savePost(Post post) async {
    final box = Hive.box<Post>(_postBox);
    if (box.length < 10) {
      await box.put(post.postId, post);
    } else {
      // Remove oldest post and add new post
      await box.deleteAt(0);
      await box.put(post.postId, post);
    }
  }

  List<Post> getPosts() {
    final box = Hive.box<Post>(_postBox);
    return box.values.toList();
  }

  Future<void> deletePost(String postId) async {
    final box = await Hive.openBox<Post>(_postBox);
    await box.delete(postId);
  }

  Future<void> updatePost(Post post) async {
    final box = await Hive.openBox<Post>(_postBox);
    await box.put(post.postId, post);
  }


  // Notification methods
  Future<void> saveNotification(NotificationModel notification) async {
    final box = Hive.box<NotificationModel>(_notificationBox);
    if (box.length < 10) {
      await box.put(notification.notificationId, notification);
    } else {
      // Remove oldest notification and add new notification
      await box.deleteAt(0);
      await box.put(notification.notificationId, notification);
    }
  }

  NotificationModel? getNotification(String id) {
    final box = Hive.box<NotificationModel>(_notificationBox);
    return box.get(id);
  }

  List<NotificationModel> getNotifications() {
    final box = Hive.box<NotificationModel>(_notificationBox);
    return box.values.toList();
  }

  Future<void> deleteNotification(String id) async {
    final box = Hive.box<NotificationModel>(_notificationBox);
    await box.delete(id);
  }

  // Message methods
  Future<void> saveMessage(MessageModel message) async {
    final box = Hive.box<MessageModel>(_messageBox);
    await box.put(message.messageId, message);
  }

  MessageModel? getMessage(String id) {
    final box = Hive.box<MessageModel>(_messageBox);
    return box.get(id);
  }

  List<MessageModel> getMessagesForUser(String userId) {
    final box = Hive.box<MessageModel>(_messageBox);
    return box.values.where((message) =>
    (message.senderId == userId || message.receiverId == userId) &&
        message.groupId == null).toList();
  }

  List<MessageModel> getMessagesForGroup(String groupId) {
    final box = Hive.box<MessageModel>(_messageBox);
    return box.values.where((message) => message.groupId == groupId).toList();
  }

  List<String> getChatsForUser(String userId) {
    final box = Hive.box<MessageModel>(_messageBox);
    Set<String> chatIds = {};
    box.values.forEach((message) {
      if (message.senderId == userId) {
        if (message.groupId != null) {
          chatIds.add(message.groupId!);
        } else {
          chatIds.add(message.receiverId);
        }
      } else if (message.receiverId == userId) {
        chatIds.add(message.senderId);
      }
    });
    return chatIds.toList();
  }
  // Notification methods


  Future<void> clearLocalData() async {
    await Hive.box<UserModel>(_userBox).clear();
    await Hive.box<Post>(_postBox).clear();
    await Hive.box<NotificationModel>(_notificationBox).clear();
    await Hive.box<MessageModel>(_messageBox).clear();
  }
  // Method to update local database with remote changes
  void updateLocalDatabaseWithRemoteChanges() {
    final remoteProvider = RemoteProvider();

    // Listen for changes in the remote database and update the local database accordingly
    remoteProvider.getUsersStream().listen((users) {
      final userBox = Hive.box<UserModel>('userBox');
      userBox.clear(); // Clear existing data
      for (final user in users) {
        userBox.put(user.uid, user);
      }
    });

    remoteProvider.getPostsStream().listen((posts) {
      final postBox = Hive.box<Post>('postBox');
      postBox.clear(); // Clear existing data
      for (final post in posts) {
        postBox.put(post.uid, post);
      }
    });

    remoteProvider.getNotificationsStreamForUser('userId').listen((notifications) {
      final notificationBox = Hive.box<NotificationModel>('notificationBox');
      notificationBox.clear(); // Clear existing data
      for (final notification in notifications) {
        notificationBox.put(notification.notificationId, notification);
      }
    });

    remoteProvider.getMessagesStreamForUser('userId').listen((messages) {
      final messageBox = Hive.box<MessageModel>('messageBox');
      messageBox.clear(); // Clear existing data
      for (final message in messages) {
        messageBox.put(message.messageId, message);
      }
    });
  }

}

