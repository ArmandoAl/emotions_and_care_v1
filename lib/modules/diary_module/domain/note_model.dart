import '../../../helpers/paths.dart';

class NoteModel {
  final int id;
  final String title;
  final String content;
  final EmotionModel emotion;
  final DateTime createdAt;
  final bool visible;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.emotion,
    required this.createdAt,
    required this.visible,
  });

  NoteModel copyWith({
    int? id,
    String? title,
    String? content,
    EmotionModel? emotion,
    DateTime? createdAt,
    bool? visible,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      emotion: emotion ?? this.emotion,
      createdAt: createdAt ?? this.createdAt,
      visible: visible ?? this.visible,
    );
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['noteId'],
      title: json['title'],
      content: json['content'],
      emotion: EmotionModel.fromJson(json['emotion']),
      createdAt: DateTime.parse(json['dateCreated']),
      visible: json['visible'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'emotion': emotion.toJson(),
      //'FechaCreacion': createdAt.toIso8601String(),
      'visible': visible,
    };
  }
}

class GoalWithNote {
  final int id;
  final GoalModel? goalModel;

  GoalWithNote({
    required this.id,
    required this.goalModel,
  });

  GoalWithNote copyWith({
    int? id,
    GoalModel? goalModel,
  }) {
    return GoalWithNote(
      id: id ?? this.id,
      goalModel: goalModel ?? this.goalModel,
    );
  }

  factory GoalWithNote.fromJson(Map<String, dynamic> json) {
    return GoalWithNote(
      id: json['noteId'],
      goalModel: json['goal'] != null ? GoalModel.fromJson(json['goal']) : null,
    );
  }
}
