import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../helpers/paths.dart';

enum RegisterPatientFlow { registerSucess, firstTestCompleted, homeUiChanged }

enum RegisterSpecialistFlow { registerSucess, licenseValidated }

class BegginCubit extends Cubit<BegginState> {
  final StorageRepository storageRepository;
  final UserRepository userRepoitory;

  BegginCubit({
    required this.storageRepository,
    required this.userRepoitory,
  }) : super(const BegginState());

  Future<String> multiLogin(String email, String password) async {
    emit(state.copyWith(status: BegginStatus.loading));

    final response = await userRepoitory.multiLogin(email, password);

    if (response == null) {
      emit(state.copyWith(status: BegginStatus.error));
      return 'error';
    }

    if (response is String) {
      emit(state.copyWith(status: BegginStatus.error));
      return response;
    }

    if (response is PatientModel) {
      PatientModel patientModel = response;
      RegisterPatientFlow flow;

      storageRepository.savePatient(response);

      if (patientModel.registerSet == false) {
        final registerPatientFlow =
            await storageRepository.getRegisterPatientFlow();
        if (registerPatientFlow != null) {
          flow = RegisterPatientFlow.values
              .firstWhere((e) => e.toString() == registerPatientFlow);
        } else {
          flow = RegisterPatientFlow.registerSucess;
        }
      } else {
        flow = RegisterPatientFlow.homeUiChanged;
      }

      emit(state.copyWith(
        status: BegginStatus.login,
        patientModel: response,
        isPatient: true,
        registerPatientFlow: flow,
        user: true,
      ));

      return 'success';
    } else {
      storageRepository.saveSpecialist(response!);

      emit(state.copyWith(
        status: BegginStatus.success,
        specialistModel: response,
        isPatient: false,
        user: true,
      ));

      return 'success';
    }
  }

  Future<void> getUser() async {
    final userData = await storageRepository.getUser();
    if (userData == null) {
      emit(state.copyWith(status: BegginStatus.error));
      return;
    }

    final user = jsonDecode(userData);

    if (user['cedulaProfesional'] != null) {
      emit(state.copyWith(
        status: BegginStatus.success,
        specialistModel: SpecialistModel.fromJson(user),
        isPatient: false,
        user: true,
      ));
    } else {
      final patientModel = PatientModel.fromJson(user, true);

      RegisterPatientFlow flow;

      if (patientModel.registerSet == false) {
        final registerPatientFlow =
            await storageRepository.getRegisterPatientFlow();
        if (registerPatientFlow != null) {
          flow = RegisterPatientFlow.values
              .firstWhere((e) => e.toString() == registerPatientFlow);
        } else {
          flow = RegisterPatientFlow.registerSucess;
        }
      } else {
        flow = RegisterPatientFlow.homeUiChanged;
      }

      emit(state.copyWith(
        status: BegginStatus.success,
        patientModel: PatientModel.fromJson(user, true),
        isPatient: true,
        registerPatientFlow: flow,
        user: true,
      ));
    }
  }

  Future<void> setRegisterSet() async {
    if (state.isPatient!) {
      final patientModel = state.patientModel!.copyWith(registerSet: true);
      storageRepository.savePatient(patientModel);
      emit(state.copyWith(patientModel: patientModel));
    }
  }

  Future<String> registerPatient(PatientModel patientModel) async {
    emit(state.copyWith(status: BegginStatus.loading));

    final response = await userRepoitory.createPatient(patientModel);

    if (response == 0) {
      emit(state.copyWith(status: BegginStatus.error));
      return 'error';
    }

    if (response == -1) {
      emit(state.copyWith(status: BegginStatus.error));
      return 'El correo ya está registrado';
    }

    if (response == -2) {
      return 'El teléfono ya está registrado';
    }

    if (response == -3) {
      return 'Error al registrar paciente, el correo o teléfono ya están registrados';
    }

    await storageRepository.saveRegisterPatientFlow(state.registerPatientFlow!);

    emit(state.copyWith(
      status: BegginStatus.success,
      isPatient: true,
    ));
    return 'success';
  }

  Future<String> registerSpecialist(SpecialistModel specialistModel) async {
    emit(state.copyWith(status: BegginStatus.loading));

    final response = await userRepoitory.createSpecialist(specialistModel);

    if (response == 0) {
      emit(state.copyWith(status: BegginStatus.error));
      return 'error';
    }

    if (response == -1) {
      emit(state.copyWith(status: BegginStatus.error));
      return 'El correo ya está registrado';
    }

    if (response == -2) {
      return 'El teléfono ya está registrado';
    }

    if (response == -3) {
      return 'Error al registrar especialista, el correo o teléfono ya están registrados';
    }

    await storageRepository.saveSpecialist(specialistModel);

    emit(state.copyWith(
      status: BegginStatus.success,
      isPatient: false,
    ));
    return 'success';
  }

  Future<void> logout() async {
    await storageRepository.clean();
    emit(const BegginState());
  }

  Future<void> setRegisterFlow(RegisterPatientFlow flow) async {
    await storageRepository.saveRegisterPatientFlow(flow);
    emit(state.copyWith(registerPatientFlow: flow));
  }

  Future<void> changePrivacy(int patientId, bool notiActivated,
      bool dairyActivated, bool progressActivated) async {
    await userRepoitory.changePrivacy(
      patientId,
      notiActivated,
      dairyActivated,
      progressActivated,
    );

    PatientModel patient = state.patientModel!.copyWith(
      settings: PattientSettings(
        notifications: notiActivated,
        diaryActivated: dairyActivated,
        testActivated: progressActivated,
        id: state.patientModel!.settings!.id,
      ),
    );

    await storageRepository.savePatient(patient);

    emit(state.copyWith(patientModel: patient, status: BegginStatus.success));
  }

  Future<void> deletePatient(int patientId) async {
    await userRepoitory.deletePatient(patientId);
    await storageRepository.clean();
    emit(const BegginState());
  }

  Future<bool> syncByCode(int id, String code) async {
    final response = await userRepoitory.syncByCode(id, code);

    if (response) {
      final newPatient = await userRepoitory.getPatient(id);

      await storageRepository.savePatient(newPatient);

      emit(state.copyWith(
        status: BegginStatus.success,
        patientModel: newPatient,
      ));

      return true;
    } else {
      emit(state.copyWith(status: BegginStatus.error));
      return false;
    }
  }
}
