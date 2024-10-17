class PattientSettings {
  final int id;
  bool notifications;
  bool diaryActivated;
  bool testActivated;

  PattientSettings({
    required this.id,
    required this.notifications,
    required this.diaryActivated,
    required this.testActivated,
  });

  PattientSettings copyWith({
    int? id,
    bool? notifications,
    bool? diaryActivated,
    bool? testActivated,
  }) {
    return PattientSettings(
      id: id ?? this.id,
      notifications: notifications ?? this.notifications,
      diaryActivated: diaryActivated ?? this.diaryActivated,
      testActivated: testActivated ?? this.testActivated,
    );
  }

  factory PattientSettings.fromJson(Map<String, dynamic> json) {
    return PattientSettings(
      id: json['settingsId'],
      notifications: json['notificationsActive'],
      diaryActivated: json['diaryActive'],
      testActivated: json['questionnaireActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'settingsId': id,
      'notificationsActive': notifications,
      'diaryActive': diaryActivated,
      'questionnaireActive': testActivated,
    };
  }
}
