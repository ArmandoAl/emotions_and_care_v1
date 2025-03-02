import '../../../../helpers/paths.dart';

class EmotionCubit extends Cubit<EmotionState> {
  EmotionCubit()
      : super(const EmotionState(emotions: [], status: EmotionStatus.initial));

  Future<void> getEmotions() async {
    emit(const EmotionState(emotions: [], status: EmotionStatus.loading));
    await Future.delayed(const Duration(microseconds: 100));
    emit(state.copyWith(
      emotions: [
        EmotionModel(
          id: 1,
          name: 'Alegría',
          icon: '😄',
          color: const Color(0xffFFFF80),
        ),
        EmotionModel(
          id: 2,
          name: 'Tristeza',
          icon: '😢',
          color: const Color(0xffC0D6E8),
        ),
        EmotionModel(
          id: 3,
          name: 'Enojo',
          icon: '😡',
          color: const Color(0xffFF6B6B),
        ),
        EmotionModel(
          id: 4,
          name: 'Sorpresa',
          icon: '😲',
          color: const Color(0xffFF9B50),
        ),
        EmotionModel(
          id: 5,
          name: 'Miedo',
          icon: '😨',
          color: const Color(0xffD895DA),
        ),
        EmotionModel(
          id: 6,
          name: 'Disgusto',
          icon: '🤢',
          color: const Color(0xffBACD92),
        ),
      ],
      status: EmotionStatus.loaded,
    ));
  }
}
