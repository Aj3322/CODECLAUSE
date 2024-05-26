import '../models/notfication_model.dart';
import '../providers/local_provider.dart';
import '../providers/remote_provider.dart';

class NotificationRepository {

  NotificationRepository._privateConstructor();

  static final NotificationRepository _instance = NotificationRepository._privateConstructor();

  factory NotificationRepository() {
    return _instance;
  }


  final RemoteProvider _remoteProvider = RemoteProvider();
  final LocalProvider _localProvider = LocalProvider();

  Future<void> sendNotification(NotificationModel notification) async {
    await _remoteProvider.sendNotification(notification);
  }

  Stream<List<NotificationModel>> getNotificationsForUser(String userId) {
    return _remoteProvider.getNotificationsForUser(userId);
  }

  Future<void> deleteNotification(String notificationId) async {
    await _remoteProvider.deleteNotification(notificationId);
  }

  Future<void> updateNotification(NotificationModel updatedNotification) async {
    await _remoteProvider.updateNotification(updatedNotification);
  }
}
