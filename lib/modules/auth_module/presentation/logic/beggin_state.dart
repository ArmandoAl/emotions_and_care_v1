import 'package:equatable/equatable.dart';

import '../../../../helpers/paths.dart';

enum BegginStatus { start, login, register, loading, error, success, initial }

class BegginState extends Equatable {
  final BegginStatus status;
  final PatientModel? patientModel;
  final SpecialistModel? specialistModel;
  final bool? isPatient;
  final bool user;
  final RegisterPatientFlow? registerPatientFlow;
  final RegisterSpecialistFlow? registerSpecialistFlow;

  const BegginState(
      {this.status = BegginStatus.start,
      this.patientModel,
      this.specialistModel,
      this.isPatient,
      this.user = false,
      this.registerPatientFlow = RegisterPatientFlow.registerSucess,
      this.registerSpecialistFlow});

  BegginState copyWith({
    BegginStatus? status,
    PatientModel? patientModel,
    SpecialistModel? specialistModel,
    bool? isPatient,
    bool? user,
    RegisterPatientFlow? registerPatientFlow,
    RegisterSpecialistFlow? registerSpecialistFlow,
  }) {
    return BegginState(
      status: status ?? this.status,
      patientModel: patientModel ?? this.patientModel,
      specialistModel: specialistModel ?? this.specialistModel,
      isPatient: isPatient ?? this.isPatient,
      user: user ?? this.user,
      registerPatientFlow: registerPatientFlow ?? this.registerPatientFlow,
      registerSpecialistFlow:
          registerSpecialistFlow ?? this.registerSpecialistFlow,
    );
  }

  @override
  List<Object> get props => [
        status,
        patientModel ?? PatientModel(),
        specialistModel ?? SpecialistModel(),
        isPatient ?? false,
        user,
        registerPatientFlow ?? RegisterPatientFlow.registerSucess,
        registerSpecialistFlow ?? RegisterSpecialistFlow.registerSucess,
      ];
}
