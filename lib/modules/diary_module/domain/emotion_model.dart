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
      id: json['emotionId'],
      name: json['name'],
      icon: emotionIcons[json['name']],
      color: emotionColors[json['name']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emotionId': id,
      'name': name,
    };
  }
}
