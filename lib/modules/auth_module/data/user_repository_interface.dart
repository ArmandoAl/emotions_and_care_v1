import '../../../helpers/paths.dart';

abstract class IUserRepository {
  Future<dynamic> multiLogin(String email, String password);

  Future<int> createPatient(PatientModel patient);

  Future<int> createSpecialist(SpecialistModel specialist);

  Future<void> setRegisterSet(int idPatient, String state);

  Future<void> changePrivacy(int patientId, bool notiActivated,
      bool dairyActivated, bool progressActivated);

  Future<void> deletePatient(int patientiD);

  Future<bool> syncByCode(int patientId, String code);

  Future<PatientModel> getPatient(int id);
}
