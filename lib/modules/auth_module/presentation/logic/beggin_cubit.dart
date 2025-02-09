import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../helpers/paths.dart';

enum RegisterSpecialistFlow { registerSuccess, licenseValidated }

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
      String status;

      storageRepository.savePatient(response);

      if (patientModel.registerStatus != "registerSuccess") {
        final registerPatientFlow =
            await storageRepository.getRegisterPatientFlow();
        if (registerPatientFlow != null) {
          status = registerPatientFlow;
        } else {
          status = "register";
        }
      } else {
        status = "registerSuccess";
      }

      emit(state.copyWith(
        status: BegginStatus.success,
        patientModel: response,
        isPatient: true,
        registerPatientFlow: status,
        user: true,
      ));

      refreshToken(patientModel.id!);

      return 'success';
    } else {
      storageRepository.saveSpecialist(response!);

      emit(state.copyWith(
        status: BegginStatus.loged,
        specialistModel: response,
        isPatient: false,
        user: true,
      ));

      return 'success';
    }
  }

  Future<void> getUser() async {
    // emit(state.copyWith(status: BegginStatus.notLoged));
    // return;

    emit(state.copyWith(status: BegginStatus.loading));

    final userData = await storageRepository.getUser();
    if (userData == null) {
      emit(state.copyWith(status: BegginStatus.notLoged));
      return;
    }

    final user = jsonDecode(userData);

    if (user['cedulaProfesional'] != null) {
      final specialist = SpecialistModel.fromJson(user);

      await multiLogin(specialist.email!, specialist.password!);

      refreshToken(specialist.id!);
    } else {
      final patientModel = PatientModel.fromJson(user, true);

      await multiLogin(patientModel.email!, patientModel.password!);

      refreshToken(patientModel.id!);
    }
  }

  Future<void> setRegisterSet(
    String registerStatus,
  ) async {
    if (state.isPatient!) {
      final patientModel =
          state.patientModel!.copyWith(registerStatus: registerStatus);
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

    await storageRepository.saveRegisterPatientFlow("register");

    emit(state.copyWith(
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

  void logout() async {
    storageRepository.clean();

    emit(const BegginState(
      status: BegginStatus.notLoged,
    ));
  }

  Future<void> setRegisterFlow(int idPatient, String flow) async {
    await storageRepository.saveRegisterPatientFlow(flow);
    await userRepoitory.setRegisterSet(idPatient, flow);
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

    emit(state.copyWith(patientModel: patient));
  }

  Future<void> deletePatient(int patientId) async {
    await userRepoitory.deletePatient(patientId);
    storageRepository.clean();
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
      emit(state.copyWith(status: BegginStatus.errorSingingWithSpecialist));
      return false;
    }
  }

  Future<bool> refreshToken(int id) async {
    final response = await userRepoitory.refreshToken(id, state.token);

    if (response) {
      if (state.isPatient == true) {
        final newPatient = state.patientModel!.copyWith(token: state.token);
        await storageRepository.savePatient(newPatient);
        emit(state.copyWith(
          status: BegginStatus.success,
          patientModel: newPatient,
        ));
      } else {
        final newSpecialist =
            state.specialistModel!.copyWith(token: state.token);
        await storageRepository.saveSpecialist(newSpecialist);

        emit(state.copyWith(
          status: BegginStatus.success,
          specialistModel: newSpecialist,
        ));
      }

      return true;
    } else {
      emit(state.copyWith(status: BegginStatus.errorSingingWithSpecialist));
      return false;
    }
  }

  void setToken(String token) {
    emit(state.copyWith(token: token));
  }
}



//register
//firstTestCompleted
//registerSuccess