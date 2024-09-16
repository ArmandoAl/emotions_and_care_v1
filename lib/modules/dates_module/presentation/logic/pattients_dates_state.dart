import 'package:equatable/equatable.dart';

import '../../../../helpers/paths.dart';

enum PattientsDatesStatus { initial, loading, loaded, error }

class PattientsDatesState extends Equatable {
  final PattientsDatesStatus status;
  final List<DateRequestModel> dates;
  const PattientsDatesState({
    this.status = PattientsDatesStatus.initial,
    this.dates = const [],
  });

  PattientsDatesState copyWith({
    PattientsDatesStatus? status,
    List<DateRequestModel>? dates,
  }) {
    return PattientsDatesState(
      status: status ?? this.status,
      dates: dates ?? this.dates,
    );
  }

  @override
  List<Object> get props => [
        status,
        dates,
      ];
}
