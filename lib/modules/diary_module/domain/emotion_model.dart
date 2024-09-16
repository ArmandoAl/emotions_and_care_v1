import '../../../helpers/paths.dart';

class EmotionModel {
  final int id;
  final String name;
  final String? icon;
  final Color? color;

  EmotionModel({
    required this.id,
    required this.name,
    this.icon,
    this.color = Colors.black,
  });

  EmotionModel copyWith({
    int? id,
    String? name,
    String? icon,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EmotionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? color,
    );
  }

  factory EmotionModel.fromJson(Map<String, dynamic> json) {
    return EmotionModel(
      id: json['idEmocion'],
      name: json['nombre'],
      icon: emotionIcons[json['nombre']],
      color: emotionColors[json['nombre']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'IdEmocion': id,
      'Nombre': name,
    };
  }
}
