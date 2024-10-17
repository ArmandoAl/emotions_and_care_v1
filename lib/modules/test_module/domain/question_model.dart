import '../../../helpers/paths.dart';

enum QuestionType { numeric, boolean, multiple, text }

class QuestionModel {
  final int id;
  final String question;
  final QuestionType type;
  final List<ResponseModel> answers;

  QuestionModel(
      {required this.question,
      required this.answers,
      required this.id,
      required this.type});

  QuestionModel copyWith({
    int? id,
    String? question,
    QuestionType? type,
    List<ResponseModel>? answers,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      question: question ?? this.question,
      type: type ?? this.type,
      answers: answers ?? this.answers,
    );
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['questionId'],
      question: json['statement'],
      type: QuestionType.values[json['type']],
      answers: List<ResponseModel>.from(
          json['answers'].map((x) => ResponseModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJsonBeck() {
    final position =
        testBeckPosition[answers.indexWhere((element) => element.isSelected)];

    return {
      'idPregunta': id,
      'posicionRespuesta': position,
    };
  }
}

const testBeckPosition = {
  0: 0,
  1: 1,
  2: 1,
  3: 2,
  4: 2,
  5: 3,
  6: 3,
};
