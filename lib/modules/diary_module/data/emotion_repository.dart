import '../../../helpers/paths.dart';

class EmotionRepository implements IEmotionRepository {
  @override
  Future<List<EmotionModel>> getEmotions() async {
    try {
      return [
        EmotionModel(
          id: 1,
          name: 'Felicidad',
          icon: '😄',
          color: const Color(0xff92D406),
        ),
        EmotionModel(
          id: 2,
          name: 'Tristeza',
          icon: '😢',
          color: const Color(0xff2C10D9),
        ),
        EmotionModel(
          id: 3,
          name: 'Miedo',
          icon: '😨',
          color: const Color(0xff8606D4),
        ),
        EmotionModel(
          id: 4,
          name: 'Disgisto',
          icon: '🤢',
          color: const Color(0xffE99E0E),
        ),
        EmotionModel(
          id: 5,
          name: 'Enojo',
          icon: '😡',
          color: const Color(0xffB71C1C),
        ),
        EmotionModel(
          id: 6,
          name: 'Sorpresa',
          icon: '😲',
          color: const Color.fromARGB(255, 142, 144, 25),
        ),
      ];
    } catch (e) {
      throw Exception('Failed to load emotions');
    }
  }
}
