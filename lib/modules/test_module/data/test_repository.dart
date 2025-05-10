import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../helpers/paths.dart';

class TestRepository implements ITestRepository {
  @override
  Future<TestInfoModelWithAchivement> completeTest(int idPaciente, int isTest,
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
          'questions': questions
              .map((e) =>
                  {'questionId': e.id, 'answerId': getPosition(e.answers)})
              .toList(),
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create patient here');
      }

      final data = jsonDecode(response.body);

      return TestInfoModelWithAchivement.fromJson(data);
    } catch (e) {
      throw Exception(e);
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

int getPosition(List<ResponseModel> answers) {
  for (int i = 0; i < answers.length; i++) {
    if (answers[i].isSelected) {
      return i;
    }
  }
  return -1;
}
