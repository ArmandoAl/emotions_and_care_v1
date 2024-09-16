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
      id: json['id'],
      notifications: json['notificacionesActivas'],
      diaryActivated: json['dirioActivado'],
      testActivated: json['progresoActivado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'notificacionesActivas': notifications,
      'dirioActivado': diaryActivated,
      'progresoActivado': testActivated,
    };
  }
}
