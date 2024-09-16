import '../../../helpers/paths.dart';

abstract class IPatientRepository {
  Future<PatientModel> getPatient(int id);

  Future<PatientModel> updatePatient(PatientModel patient);

  Future<bool> relatePatientWithSpecialist(
      int patientId, String specialistIdToken);
}
