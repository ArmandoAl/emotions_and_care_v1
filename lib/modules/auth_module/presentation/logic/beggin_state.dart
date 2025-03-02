import 'package:equatable/equatable.dart';

import '../../../../helpers/paths.dart';

enum BegginStatus {
  start,
  login,
  register,
  loading,
  error,
  success,
  initial,
  loged,
  logind,
  notLoged,
  errorSingingWithSpecialist,
  growing,
  relogin
}

class BegginState extends Equatable {
  final BegginStatus status;
  final PatientModel? patientModel;
  final SpecialistModel? specialistModel;
  final bool? isPatient;
  final bool user;
  final String? registerPatientFlow;
  final RegisterSpecialistFlow? registerSpecialistFlow;
  final String token;

  const BegginState(
      {this.status = BegginStatus.start,
      this.patientModel,
      this.specialistModel,
      this.isPatient,
      this.user = false,
      this.registerPatientFlow = "registerSuccess",
      this.registerSpecialistFlow,
      this.token = ""});

  BegginState copyWith({
    BegginStatus? status,
    PatientModel? patientModel,
    SpecialistModel? specialistModel,
    bool? isPatient,
    bool? user,
    String? registerPatientFlow,
    RegisterSpecialistFlow? registerSpecialistFlow,
    String? token,
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
      token: token ?? this.token,
    );
  }

  @override
  List<Object> get props => [
        status,
        patientModel ?? PatientModel(),
        specialistModel ?? SpecialistModel(),
        isPatient ?? false,
        user,
        registerPatientFlow ?? "registerSuccess",
        registerSpecialistFlow ?? RegisterSpecialistFlow.registerSuccess,
        token
      ];
}
