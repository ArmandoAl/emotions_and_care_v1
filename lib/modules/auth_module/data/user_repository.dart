import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../helpers/paths.dart';

class UserRepository implements IUserRepository {
  @override
  Future<dynamic> multiLogin(String email, String password) async {
    final response = await http.post(
      Uri.parse('${Api.baseUrl}Usuario/$email/multiLogin/$password'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );

    final data = jsonDecode(response.body);

    //if bad request
    if (response.statusCode == 200) {
      if (data['license'] != null) {
        return SpecialistModel.fromJson(data);
      } else {
        return PatientModel.fromJson(data, true);
      }
    } else {
      if (response.statusCode == 400) {
        return data;
      }
      return null;
    }
  }

  @override
  Future<int> createPatient(PatientModel patient) async {
    try {
      final response = await http.post(
        Uri.parse('${Api.baseUrl}Paciente'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(patient.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to create patient');
      }

      return int.parse(response.body);
    } catch (e) {
      return -3;
    }
  }

  @override
  Future<int> createSpecialist(SpecialistModel specialist) async {
    try {
      final response = await http.post(
        Uri.parse('${Api.baseUrl}Especialista'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(specialist.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to create specialist');
      }

      return int.parse(response.body);
    } catch (e) {
      return -3;
    }
  }

  @override
  Future<void> setRegisterSet(int idPatient, String state) async {
    try {
      final response = await http.put(
        Uri.parse('${Api.baseUrl}Paciente/$idPatient/registerSet/$state'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to set register set');
      }
    } catch (e) {
      throw Exception('Failed to set register set');
    }
  }

  @override
  Future<void> changePrivacy(int patientId, bool notiActivated,
      bool dairyActivated, bool progressActivated) async {
    try {
      final response = await http.put(
        Uri.parse(
            '${Api.baseUrl}Paciente/$patientId/MoficarConfiguracionNotificaciones/$notiActivated/$dairyActivated/$progressActivated'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to change privacy');
      }
    } catch (e) {
      throw Exception('Failed to change privacy');
    }
  }

  @override
  Future<void> deletePatient(int patientiD) async {
    try {
      final response = await http.delete(
        Uri.parse('${Api.baseUrl}Paciente/$patientiD'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete patient');
      }
    } catch (e) {
      throw Exception('Failed to delete patient');
    }
  }

  @override
  Future<bool> syncByCode(int patientId, String code) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${Api.baseUrl}Paciente/$patientId/vincularEspecialista/$code'),
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
      throw Exception('Failed to sync by code');
    }
  }

  @override
  Future<bool> vincularPaciente(int specialistId, int patientId) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${Api.baseUrl}Paciente/$specialistId/vincularPaciente/$patientId'),
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
      throw Exception('Failed to sync by code');
    }
  }

  @override
  Future<bool> syncByDirectCode(int id, String code) async {
    try {
      final response = await http.post(
        Uri.parse('${Api.baseUrl}Paciente/$id/vincularDirecto/$code'),
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
      throw Exception('Failed to sync by direct code');
    }
  }

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
        throw Exception('Failed to get patient');
      }

      return PatientModel.fromJson(jsonDecode(response.body), true);
    } catch (e) {
      throw Exception('Failed to get patient');
    }
  }

  @override
  Future<dynamic> refreshToken(int id, String token) async {
    try {
      final response = await http.put(
        Uri.parse('${Api.baseUrl}Usuario/refreshToken/$id/$token'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        return null;
      }

      final data = jsonDecode(response.body);

      if (data['license'] != null) {
        return SpecialistModel.fromJson(data);
      } else {
        return PatientModel.fromJson(data, true);
      }
    } catch (e) {
      return null;
    }
  }
}
