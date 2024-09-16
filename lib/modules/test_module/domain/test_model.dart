import '../../../helpers/paths.dart';

class TestModel {
  final int id;
  final String name;
  final String description;
  final String objetive;
  final String instructions;
  final List<QuestionModel> questions;

  TestModel({
    required this.id,
    required this.name,
    required this.description,
    required this.objetive,
    required this.instructions,
    required this.questions,
  });

  TestModel copyWith({
    int? id,
    String? name,
    String? description,
    String? objetive,
    String? instructions,
    List<QuestionModel>? questions,
  }) {
    return TestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      objetive: objetive ?? this.objetive,
      instructions: instructions ?? this.instructions,
      questions: questions ?? this.questions,
    );
  }

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['idCuestionario'],
      name: json['nombreCuestionario'],
      description: json['descripcion'],
      objetive: json['objetivo'],
      instructions: json['instrucciones'],
      questions: List<QuestionModel>.from(
          json['preguntas'].map((x) => QuestionModel.fromJson(x))),
    );
  }
}
