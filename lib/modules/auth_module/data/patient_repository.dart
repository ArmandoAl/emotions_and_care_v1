import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../helpers/paths.dart';

class PatientRepository implements IPatientRepository {
  @override
  Future<PatientModel> getPatient(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Paciente/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load patient');
      }

      return PatientModel.fromJson(jsonDecode(response.body), true);
    } catch (e) {
      throw Exception('Failed to load patient');
    }
  }

  @override
  Future<bool> relatePatientWithSpecialist(
      int patientId, String specialistIdToken) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${Api.baseUrl}Paciente/$patientId/vincularEspecialista/$specialistIdToken'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to relate patient with specialist');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to relate patient with specialist');
    }
  }

  @override
  Future<PatientModel> updatePatient(PatientModel patient) async {
    try {
      final response = await http.put(
        Uri.parse('${Api.baseUrl}Paciente/${patient.id}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(patient.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update patient');
      }

      return PatientModel.fromJson(jsonDecode(response.body), true);
    } catch (e) {
      throw Exception('Failed to update patient');
    }
  }
}
