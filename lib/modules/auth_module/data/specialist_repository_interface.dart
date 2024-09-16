import '../../../helpers/paths.dart';

abstract class ISpecialistRepository {
  Future<SpecialistModel> getSpecialist(int id);

  Future<SpecialistModel> updateSpecialist(SpecialistModel specialist);

  Future<bool> relateSpecialistWithPatient(
      int specialistId, String patientIdToken);

  Future<List<PatientModel>> getPatients(int idSpecialist);
}
