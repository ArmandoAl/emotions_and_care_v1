import '../../../helpers/paths.dart';

abstract class INotificationRepository {
  Future<bool> deleteNotification(int id);

  Future<NotificationModel> getNotification(int id);

  Future<List<NotificationModel>> init(int id);
}
