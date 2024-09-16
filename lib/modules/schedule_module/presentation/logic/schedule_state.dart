import 'package:equatable/equatable.dart';
import '../../../../helpers/paths.dart';

enum ScheduleStatus { initial, loading, loaded, error }

class ScheduleState extends Equatable {
  final List<DateModel> dates;
  final ScheduleStatus status;
  final List<SpecialistModel> specialists;
  final List<SpecialistModel> auxiliar;
  final int offset;
  final bool isTheTotal;

  const ScheduleState(
      {this.dates = const <DateModel>[],
      this.status = ScheduleStatus.initial,
      this.specialists = const <SpecialistModel>[],
      this.auxiliar = const <SpecialistModel>[],
      this.offset = 0,
      this.isTheTotal = false});

  ScheduleState copyWith({
    List<DateModel>? dates,
    ScheduleStatus? status,
    List<SpecialistModel>? specialists,
    List<SpecialistModel>? auxiliar,
    int? offset,
    bool? isTheTotal,
  }) {
    return ScheduleState(
      dates: dates ?? this.dates,
      status: status ?? this.status,
      specialists: specialists ?? this.specialists,
      auxiliar: auxiliar ?? this.auxiliar,
      offset: offset ?? this.offset,
      isTheTotal: isTheTotal ?? this.isTheTotal,
    );
  }

  @override
  List<Object> get props => [
        dates,
        status,
        specialists,
        auxiliar,
        offset,
        isTheTotal,
      ];
}
