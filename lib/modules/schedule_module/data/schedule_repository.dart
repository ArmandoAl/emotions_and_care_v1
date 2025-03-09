import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../helpers/paths.dart';

class ScheduleRepository implements IScheduleRepository {
  @override
  Future<GoalwithDate> addSchedule(
      int id, DateModel date, int idSpecialist) async {
    try {
      final response = await http.post(
        Uri.parse('${Api.baseUrl}Cita/$id/AgregarCita/$idSpecialist'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(date.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add schedule');
      }
      return GoalwithDate.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to add schedule');
    }
  }

  @override
  Future<bool> cancelDateByPatient(int idDate, int idPatient) async {
    try {
      final response = await http.put(
        Uri.parse(
            '${Api.baseUrl}Cita/$idDate/CancelarCitaPorPaciente/$idPatient'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to cancel date');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to cancel date');
    }
  }

  @override
  Future<bool> cancelDateBySpecialist(
      int idDate, int idSpecialist, int idPatient) async {
    try {
      final response = await http.put(
        Uri.parse(
            '${Api.baseUrl}Cita/$idDate/CancelarCitaPorEspecialista/$idSpecialist/$idPatient'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to cancel date');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to cancel date');
    }
  }

  @override
  Future<bool> confirmDateByPatient(int idDate, int idPatient) async {
    try {
      final response = await http.put(
        Uri.parse(
            '${Api.baseUrl}Cita/$idDate/ConfirmarCitaPorPaciente/$idPatient'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to confirm date');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to confirm date');
    }
  }

  @override
  Future<bool> confirmDateBySpecialist(
      int idDate, int idSpecialist, int idPatient) async {
    try {
      final response = await http.put(
        Uri.parse(
            '${Api.baseUrl}Cita/$idDate/ConfirmarCitaPorEspecialista/$idSpecialist/$idPatient'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to confirm date');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to confirm date');
    }
  }

  @override
  Future<bool> deleteSchedule(int dateId) async {
    try {
      final response = await http.delete(
        Uri.parse('${Api.baseUrl}Cita/$dateId'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete schedule');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to delete schedule');
    }
  }

  @override
  Future<List<DateModel>> getSchedules(int isPatient) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Cita/$isPatient/Citas'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((e) => DateModel.fromJson(e, true))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load schedules');
    }
  }

  @override
  Future<bool> updateSchedule(DateModel date, int patientId, int specialistId,
      bool isFromSpecialist) async {
    try {
      final response = await http.put(
        Uri.parse(
            '${Api.baseUrl}Cita/$patientId/actualizarCita/$isFromSpecialist/$specialistId'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(date.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update schedule');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to update schedule');
    }
  }

  @override
  Future<List<DateRequestModel>> getDatesRequest(int idSpecialist) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Especialista/$idSpecialist/solicitudesCitas'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        return [];
      } else {
        return (jsonDecode(response.body) as List)
            .map((e) => DateRequestModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      throw Exception('Failed to load schedules');
    }
  }

  @override
  Future<List<DateModel>> getDatesForSpecialist(int idSpecialist) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Cita/$idSpecialist/CitasDelEspecialist'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((e) => DateModel.fromJson(e, false))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load schedules');
    }
  }

  @override
  Future<List<SpecialistModel>> getSpecialists(int offset) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Especialista/listarEspecialistas/$offset/15'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((e) => SpecialistModel.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load specialists');
      }
    } catch (e) {
      throw Exception('Failed to load specialists');
    }
  }

  @override
  Future<int> addDateBySpecialist(
      int idSpecialist, DateModel date, int idPatient) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${Api.baseUrl}Cita/$idSpecialist/AgregarCitaEspecialista/$idPatient'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(date.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create date');
      }

      return int.parse(response.body);
    } catch (e) {
      throw Exception('Failed to create date');
    }
  }

  @override
  Future<bool> rejectDate(int idSpecialist, int idDate) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${Api.baseUrl}Especialista/$idSpecialist/rechazarCita/$idDate'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to reject date');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to reject date');
    }
  }

  @override
  Future<bool> aceptDateBySpecialist(int idSpecialist, int idDate) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${Api.baseUrl}Especialista/$idSpecialist/aceptarCita/$idDate'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to accept date');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to accept date');
    }
  }
}
