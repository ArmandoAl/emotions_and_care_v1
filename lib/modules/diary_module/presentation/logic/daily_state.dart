import 'package:equatable/equatable.dart';

import '../../../../helpers/paths.dart';

enum DailyResult { initial, loading, success, error }

class DailyState extends Equatable {
  final List<NoteModel> notes;
  final DailyResult result;
  final bool visible;

  const DailyState({
    this.notes = const [],
    this.result = DailyResult.initial,
    this.visible = false,
  });

  @override
  List<Object> get props => [
        notes,
        result,
        visible,
      ];

  DailyState copyWith({
    List<NoteModel>? notes,
    DailyResult? result,
    bool? visible,
  }) {
    return DailyState(
      notes: notes ?? this.notes,
      result: result ?? this.result,
      visible: visible ?? this.visible,
    );
  }
}
