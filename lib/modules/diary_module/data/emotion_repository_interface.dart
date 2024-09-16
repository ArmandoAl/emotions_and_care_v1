import '../../../helpers/paths.dart';

abstract class IEmotionRepository {
  Future<List<EmotionModel>> getEmotions();
}
