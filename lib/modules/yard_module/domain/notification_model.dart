enum NotificationType {
  notificacionRecordatorio,
  notificacionRecomendacion,
  notificacionNota,
  goal,
  growNotifications,
  sticker
}

enum RecomendationType { recomendacion, recordatorio }

class NotificationModel {
  final int id;
  final String title;
  final NotificationType type;
  final String description;
  final DateTime? dateEmition;
  final int? idRecomendation;
  final RecomendationType? recomendationType;
  final String? reference;
  final String? url;
  final bool? completed;
  final int? idAchievement;

  NotificationModel({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    this.dateEmition,
    this.idRecomendation,
    this.recomendationType,
    this.reference,
    this.url,
    this.completed = false,
    this.idAchievement,
  });

  NotificationModel copyWith({
    int? id,
    String? title,
    NotificationType? type,
    String? description,
    DateTime? dateEmition,
    int? idRecomendation,
    RecomendationType? recomendationType,
    String? reference,
    String? url,
    bool? completed,
    int? idAchievement,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      dateEmition: dateEmition ?? this.dateEmition,
      idRecomendation: idRecomendation ?? this.idRecomendation,
      recomendationType: recomendationType ?? this.recomendationType,
      reference: reference ?? this.reference,
      url: url ?? this.url,
      completed: completed ?? this.completed,
      idAchievement: idAchievement ?? this.idAchievement,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['notificationId'],
      title: json['titulo'],
      type: json['notificationType'] == null
          ? NotificationType.notificacionNota
          : NotificationType.values[json['notificationType']],
      description: json['descripcion'],
      idRecomendation: json['recomendationId'],
      recomendationType: json['recomendationType'] == null
          ? null
          : RecomendationType.values[json['recomendationType']],
      reference: json['reference'],
      url: json['url'],
      dateEmition: json['fechaEmision'] == null
          ? null
          : DateTime.tryParse(json['fechaEmision']),
      completed: json['completed'] == null
          ? false
          : json['completed'] == 1
              ? true
              : false,
      idAchievement: json['achievementId'],
    );
  }
}
