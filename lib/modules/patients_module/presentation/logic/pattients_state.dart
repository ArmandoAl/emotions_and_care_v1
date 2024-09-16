import 'package:equatable/equatable.dart';

import '../../../../helpers/paths.dart';

enum PattientsStatus { initial, loading, loaded, error }

class PattientsState extends Equatable {
  final List<PatientModel> patients;
  final PattientsStatus status;

  const PattientsState({
    this.patients = const [],
    this.status = PattientsStatus.initial,
  });

  PattientsState copyWith({
    List<PatientModel>? patients,
    PattientsStatus? status,
  }) {
    return PattientsState(
      patients: patients ?? this.patients,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        patients,
        status,
      ];
}
