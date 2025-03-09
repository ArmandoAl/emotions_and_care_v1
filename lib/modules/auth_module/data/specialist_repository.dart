import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../helpers/paths.dart';

class SpecialistRepository implements ISpecialistRepository {
  @override
  Future<SpecialistModel> getSpecialist(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Especialista/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load specialist');
      }

      return SpecialistModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to load specialist');
    }
  }

  @override
  Future<bool> relateSpecialistWithPatient(
      int specialistId, String patientToken) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${Api.baseUrl}Especialista/$specialistId/vincularPaciente/$patientToken'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to relate specialist with patient');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to relate specialist with patient');
    }
  }

  @override
  Future<SpecialistModel> updateSpecialist(SpecialistModel specialist) async {
    try {
      final response = await http.put(
        Uri.parse('${Api.baseUrl}Especialista'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(specialist.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update specialist');
      }

      return SpecialistModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to update specialist');
    }
  }

  @override
  Future<List<PatientModel>> getPatients(int idSpecialist) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Especialista/$idSpecialist/pacientes'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((e) => PatientModel.fromJson(e, false))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load patients');
    }
  }

  @override
  Future<List<PatientRequest>> getPatientRequest(int idSpecialist) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Api.baseUrl}Especialista/$idSpecialist/getPatientsRequest'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((e) => PatientRequest.fromMap(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load patient requests');
    }
  }

  @override
  Future<bool> acceptPatientRequest(int idSpecialist, int idPatient) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${Api.baseUrl}Especialista/$idSpecialist/aceptarSolicitud/$idPatient'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        return false;
      }

      return true;
    } catch (e) {
      throw Exception('Failed to accept patient request');
    }
  }

  @override
  Future<bool> rejectPatientRequest(int idSpecialist, int idPatient) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${Api.baseUrl}Especialista/$idSpecialist/rechazarSolicitud/$idPatient'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        return false;
      }

      return true;
    } catch (e) {
      throw Exception('Failed to reject patient request');
    }
  }
}
