import 'dart:convert';
import 'package:emotions_and_care_v1/helpers/paths.dart';

enum RegisterPatientFlow { registerSucess, firstTestCompleted, homeUiChanged }

enum RegisterSpecialistFlow { registerSucess, licenseValidated }

class UserProvider extends ChangeNotifier {
  PatientModel? patientModel;
  SpecialistModel? specialistModel;
  bool? isPatient;
  bool isLoading = true;
  bool user = false;
  RegisterPatientFlow? registerPatientFlow = RegisterPatientFlow.registerSucess;
  RegisterSpecialistFlow? registerSpecialistFlow;

  final UserRepository _userRepository;
  final StorageRepository _storageRepository;

  UserProvider({
    required UserRepository userRepository,
    required StorageRepository storageRepository,
  })  : _userRepository = userRepository,
        _storageRepository = storageRepository;

  Future<String> multiLogin(String email, String password) async {
    final response = await _userRepository.multiLogin(email, password);

    if (response == null) {
      isLoading = false;
      notifyListeners();
      return 'error';
    }

    if (response is String) {
      isLoading = false;
      notifyListeners();
      return response;
    }

    if (response is PatientModel) {
      isPatient = true;
      patientModel = response;
      _storageRepository.savePatient(patientModel!);

      if (patientModel!.registerSet == false) {
        final registerPatientFlow =
            await _storageRepository.getRegisterPatientFlow();
        if (registerPatientFlow != null) {
          this.registerPatientFlow = RegisterPatientFlow.values
              .firstWhere((e) => e.toString() == registerPatientFlow);
        } else {
          this.registerPatientFlow = RegisterPatientFlow.registerSucess;
        }
      } else {
        registerPatientFlow = RegisterPatientFlow.homeUiChanged;
      }
    } else {
      isPatient = false;
      specialistModel = response;
      _storageRepository.saveSpecialist(specialistModel!);
    }

    user = true;
    isLoading = false;
    notifyListeners();

    return 'success';
  }

  Future<void> getUser() async {
    final userData = await _storageRepository.getUser();
    if (userData == null) {
      isLoading = false;
      notifyListeners();
      return;
    }
    //verify if user is a patient or a specialist by checking the json and the key 'cedulaProfesional'
    final data = jsonDecode(userData);
    if (data['cedulaProfesional'] != null) {
      specialistModel = SpecialistModel.fromJson(data);
      isPatient = false;
    } else {
      patientModel = PatientModel.fromJson(data, true);
      isPatient = true;

      if (patientModel!.registerSet == false) {
        final registerPatientFlow =
            await _storageRepository.getRegisterPatientFlow();
        if (registerPatientFlow != null) {
          this.registerPatientFlow = RegisterPatientFlow.values
              .firstWhere((e) => e.toString() == registerPatientFlow);
        } else {
          this.registerPatientFlow = RegisterPatientFlow.registerSucess;
        }
      } else {
        registerPatientFlow = RegisterPatientFlow.homeUiChanged;
      }
    }

    user = true;
    isLoading = false;
    notifyListeners();
  }

  Future<void> setRegisterSet() async {
    if (isPatient!) {
      patientModel = patientModel!.copyWith(registerSet: true);
      await _userRepository.setRegisterSet(patientModel!.id);
      await _storageRepository.savePatient(patientModel!);
    }
  }

  Future<String> registerPattient(PatientModel patient) async {
    print(patient.toJson());
    final response = await _userRepository.createPatient(patient);

    if (response == 0) {
      return 'error';
    }

    if (response == -1) {
      return 'El correo ya está registrado';
    }

    if (response == -2) {
      return 'El teléfono ya está registrado';
    }

    if (response == -3) {
      return 'Error al registrar paciente, el correo o teléfono ya están registrados';
    }

    await _storageRepository.saveRegisterPatientFlow(registerPatientFlow!);

    isPatient = true;
    notifyListeners();
    return 'success';
  }

  Future<String> registerSpecialist(SpecialistModel specialist) async {
    final response = await _userRepository.createSpecialist(specialist);

    if (response == 0) {
      return 'error';
    }

    if (response == -1) {
      return 'El correo ya está registrado';
    }

    if (response == -2) {
      return 'El teléfono ya está registrado';
    }

    if (response == -3) {
      return 'Error al registrar especialista, el correo o teléfono ya están registrados';
    }

    await _storageRepository.saveSpecialist(specialist);

    isPatient = false;

    notifyListeners();
    return 'success';
  }

  Future<void> logout(BuildContext context) async {
    await _storageRepository.clean();
    patientModel = null;
    specialistModel = null;
    isPatient = null;
    user = false;
    isLoading = false;
    registerPatientFlow = RegisterPatientFlow.registerSucess;
    notifyListeners();

    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (context) => const GuideFlowController(),
    //   ),
    //   (route) => false,
    // );
  }

  Future<void> setRegisterFlow(RegisterPatientFlow registerPatientFlow) async {
    await _storageRepository.saveRegisterPatientFlow(registerPatientFlow);

    this.registerPatientFlow = registerPatientFlow;
    notifyListeners();
  }

  Future<void> changePrivacy(int patientId, bool notiActivated,
      bool dairyActivated, bool progressActivated) async {
    await _userRepository.changePrivacy(
        patientId, notiActivated, dairyActivated, progressActivated);
    patientModel = patientModel!.copyWith(
        settings: PattientSettings(
            notifications: notiActivated,
            diaryActivated: dairyActivated,
            testActivated: progressActivated,
            id: patientModel!.settings!.id));

    await _storageRepository.savePatient(patientModel!);

    notifyListeners();
  }

  Future<void> deletePatient(int patientiD) async {
    await _userRepository.deletePatient(patientiD);
    await _storageRepository.clean();
    patientModel = null;
    specialistModel = null;
    isPatient = null;
    user = false;
    isLoading = false;
    notifyListeners();
  }

  Future<bool> syncByCode(int id, String code) async {
    final response = await _userRepository.syncByCode(id, code);

    if (response) {
      final newPatient = await _userRepository.getPatient(id);

      patientModel = newPatient;
      await _storageRepository.savePatient(patientModel!);

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
