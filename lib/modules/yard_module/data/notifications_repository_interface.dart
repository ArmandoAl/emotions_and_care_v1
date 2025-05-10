import '../../../helpers/paths.dart';

abstract class INotificationRepository {
  Future<bool> deleteNotification(int id);

  Future<NotificationModel> getNotification(int id);

  Future<List<NotificationModel>> init(int id);

  Future<bool> growStage(int id);

  Future<bool> growFlower(int idPatient, int idUserFlower);

  Future<bool> canGrowStage(int idPatient);

  Future<bool> recomendationCompleted(int idRecomendacion, int idPatient);

  Future<bool> posponeNote(int idNote);
}
