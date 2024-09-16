import 'package:equatable/equatable.dart';
import '../../../../helpers/paths.dart';

enum EmotionStatus { initial, loading, loaded, error }

class EmotionState extends Equatable {
  final EmotionStatus status;
  final List<EmotionModel> emotions;

  const EmotionState({required this.emotions, required this.status});

  EmotionState copyWith({
    List<EmotionModel>? emotions,
    EmotionStatus? status,
  }) {
    return EmotionState(
      emotions: emotions ?? this.emotions,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [emotions, status];
}
