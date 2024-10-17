import '../../../helpers/paths.dart';

class TestInfoModel {
  final int id;
  final String resultado;
  final DateTime date;
  final List<TestQuestionWithAnswer> testQuestionWithAnswerList;

  TestInfoModel({
    required this.id,
    required this.resultado,
    required this.date,
    required this.testQuestionWithAnswerList,
  });

  TestInfoModel copyWith({
    int? id,
    String? resultado,
    DateTime? date,
    List<TestQuestionWithAnswer>? testQuestionWithAnswerList,
  }) {
    return TestInfoModel(
      id: id ?? this.id,
      resultado: resultado ?? this.resultado,
      date: date ?? this.date,
      testQuestionWithAnswerList:
          testQuestionWithAnswerList ?? this.testQuestionWithAnswerList,
    );
  }

  factory TestInfoModel.fromJson(Map<String, dynamic> json) {
    return TestInfoModel(
      id: json['testInfoModelId'],
      resultado: json['result'],
      date: DateTime.parse(json['date']),
      testQuestionWithAnswerList: List<TestQuestionWithAnswer>.from(
          json['testQuestionWithAnswers']
              .map((x) => TestQuestionWithAnswer.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'resultado': resultado,
      'date': date.toIso8601String(),
      'testQuestionWithAnswerList':
          testQuestionWithAnswerList.map((x) => x.toJson()).toList(),
    };
  }
}
