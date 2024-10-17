enum GoalType {
  test,
  specialist,
  recomendation,
  community,
}

class GoalModel {
  int? id;
  String title;
  GoalType type;
  String description;
  int? idSticker;
  int? idFlor;

  GoalModel({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    this.idSticker,
    this.idFlor,
  });

  GoalModel copyWith({
    int? id,
    String? title,
    GoalType? type,
    String? description,
    int? idSticker,
    int? idFlor,
  }) {
    return GoalModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      idSticker: idSticker ?? this.idSticker,
      idFlor: idFlor ?? this.idFlor,
    );
  }

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['goalId'],
      title: json['name'],
      type: GoalType.values[json['type']],
      description: json['desription'],
      idSticker: json['stickerId'],
      idFlor: json['stickerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'goalId': id,
      'name': title,
      'type': type.index,
      'desription': description,
      'stickerId': idSticker,
      'flowerId': idFlor,
    };
  }
}
