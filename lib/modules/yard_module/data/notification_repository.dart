import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../helpers/paths.dart';

class NotificationRepository implements INotificationRepository {
  @override
  Future<bool> deleteNotification(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('${Api.baseUrl}Notificacion/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create patient');
      }

      return true;
    } catch (e) {
      throw Exception('Failed on delete notification');
    }
  }

  @override
  Future<NotificationModel> getNotification(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Notificacion/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load notifications');
      }

      return NotificationModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to load notifications');
    }
  }

  @override
  Future<List<NotificationModel>> init(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Notificacion/$id/init'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load notifications');
      }

      return (jsonDecode(response.body) as List)
          .map((e) => NotificationModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to load notifications');
    }
  }

  @override
  Future<bool> growStage(int id) async {
    try {
      final response = await http.put(
        Uri.parse('${Api.baseUrl}/Paciente/$id/growStage'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to grow stage');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to grow stage');
    }
  }

  @override
  Future<bool> growFlower(int idPatient, int idUserFlower) async {
    try {
      final response = await http.put(
        Uri.parse(
            '${Api.baseUrl}/Paciente/$idPatient/growFlower/$idUserFlower'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to grow flower');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to grow flower');
    }
  }

  @override
  Future<bool> canGrowStage(int idPatient) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}/Paciente/$idPatient/canGrowFlower'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to grow stage');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to grow stage');
    }
  }
}
