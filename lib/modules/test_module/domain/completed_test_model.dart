class CompletedTestModel {
  int testId;
  DateTime date;
  int userId;

  CompletedTestModel({
    required this.testId,
    required this.date,
    required this.userId,
  });

  CompletedTestModel copyWith({
    int? testId,
    DateTime? date,
    int? userId,
  }) {
    return CompletedTestModel(
      testId: testId ?? this.testId,
      date: date ?? this.date,
      userId: userId ?? this.userId,
    );
  }

  factory CompletedTestModel.fromJson(Map<String, dynamic> json) {
    return CompletedTestModel(
      testId: json['questionnaireId'],
      date: DateTime.tryParse(json['dateCompleted']) ?? DateTime.now(),
      userId: json['patientId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionnaireId': testId,
      'dateCompleted': date.toIso8601String(),
    };
  }
}
