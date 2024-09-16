import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../helpers/paths.dart';

class TestRepository implements ITestRepository {
  @override
  Future<GoalWithTestInfoModel> completeTest(int idPaciente, int isTest,
      List<QuestionModel> questions, bool isFirtsTime) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${Api.baseUrl}Cuestionario/$idPaciente/completarCuestionario/$isTest/$isFirtsTime'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'preguntas': questions.map((e) => e.toJsonBeck()).toList(),
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create patient here');
      }

      final data = jsonDecode(response.body);

      return GoalWithTestInfoModel.fromJson(data);
    } catch (e) {
      throw Exception('Failed to create patient down here');
    }
  }

  @override
  Future<CompleteTestHistory> getTest(int pacienteId) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Api.baseUrl}Cuestionario/$pacienteId/obtenerCuestionarios'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load test');
      }
      return CompleteTestHistory.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed on getTest');
    }
  }
}
