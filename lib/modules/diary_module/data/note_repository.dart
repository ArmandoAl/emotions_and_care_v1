import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../helpers/paths.dart';

class NoteRepository implements INoteRepository {
  @override
  Future<GoalWithNote> addNote(
      NoteModel note, int patientId, bool isFirstTine) async {
    try {
      final response = await http.post(
        Uri.parse('${Api.baseUrl}Nota/$patientId/AgregarNota/$isFirstTine'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(note.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add note');
      }

      return GoalWithNote.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to add note');
    }
  }

  @override
  Future<List<NoteModel>> getNotes(int patientId) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Nota/$patientId/Notas'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        return [];
      }

      return (jsonDecode(response.body) as List)
          .map((e) => NoteModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to load notes');
    }
  }

  @override
  Future<bool> deleteNote(int idNote) async {
    try {
      final response = await http.delete(
        Uri.parse('${Api.baseUrl}Nota/$idNote'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update note');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to update note');
    }
  }
}
