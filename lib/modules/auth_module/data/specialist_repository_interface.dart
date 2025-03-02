import '../../../helpers/paths.dart';

abstract class ISpecialistRepository {
  Future<SpecialistModel> getSpecialist(int id);

  Future<SpecialistModel> updateSpecialist(SpecialistModel specialist);

  Future<bool> relateSpecialistWithPatient(
      int specialistId, String patientIdToken);

  Future<List<PatientModel>> getPatients(int idSpecialist);

  Future<List<PatientRequest>> getPatientRequest(int idSpecialist);

  Future<bool> acceptPatientRequest(int idSpecialist, int idPatient);

  Future<bool> rejectPatientRequest(int idSpecialist, int idPatient);
}

class PatientRequest {
  final int id;
  final PatientModel patient;

  PatientRequest({required this.id, required this.patient});

  PatientRequest copyWith({
    int? id,
    PatientModel? patient,
  }) {
    return PatientRequest(
      id: id ?? this.id,
      patient: patient ?? this.patient,
    );
  }

  Map<String, dynamic> toMap() {
    return {'patientRequestId': id, 'patient': patient.toJson()};
  }

  factory PatientRequest.fromMap(Map<String, dynamic> map) {
    return PatientRequest(
      id: map['patientRequestId'],
      patient: PatientModel.fromJson(map['patient'], false),
    );
  }
}
