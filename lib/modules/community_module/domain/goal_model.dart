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
      id: json['idLogro'],
      title: json['nombre'],
      type: GoalType.values[json['tipo']],
      description: json['descripcion'],
      idSticker: json['idSticker'],
      idFlor: json['idFlor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type.index,
      'description': description,
      'idSticker': idSticker,
      'idFlor': idFlor,
    };
  }
}
