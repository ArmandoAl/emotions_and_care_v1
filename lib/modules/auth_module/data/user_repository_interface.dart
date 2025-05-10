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

  Future<bool> syncByDirectCode(int id, String code);

  Future<PatientModel> getPatient(int id);

  Future<dynamic> refreshToken(int id, String token);

  Future<bool> vincularPaciente(int specialistId, int patientId);

  Future<int> updatePatient(
    PatientModel patient,
  );

  Future<int> updateSpecialist(
    SpecialistModel specialist,
  );

  Future<bool> recoverPassword(
    String email,
  );

  Future<bool> validateCode(
    String email,
    String code,
  );

  Future<bool> changePassword(
    String email,
    String password,
  );
}
