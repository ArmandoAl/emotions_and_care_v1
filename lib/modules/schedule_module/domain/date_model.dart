import '../../../helpers/paths.dart';

class DateModel {
  final int? id;
  final DateTime? date;
  final String? hour;
  final String? place;
  final String? description;
  bool? confirmByPatient;
  bool? confirmByEspetialist;
  PatientModel? patient;

  DateModel({
    this.id,
    required this.date,
    required this.hour,
    required this.place,
    required this.description,
    required this.confirmByPatient,
    required this.confirmByEspetialist,
    this.patient,
  });

  DateModel copyWith({
    int? id,
    DateTime? date,
    String? hour,
    String? place,
    String? description,
    bool? confirmByPatient,
    bool? confirmByEspetialist,
    PatientModel? patient,
  }) {
    return DateModel(
      id: id ?? this.id,
      date: date ?? this.date,
      hour: hour ?? this.hour,
      place: place ?? this.place,
      description: description ?? this.description,
      confirmByPatient: confirmByPatient ?? this.confirmByPatient,
      confirmByEspetialist: confirmByEspetialist ?? this.confirmByEspetialist,
      patient: patient ?? this.patient,
    );
  }

  factory DateModel.fromJson(Map<String, dynamic> json, bool isPatient) {
    return DateModel(
      id: json['dateId'],
      date: DateTime.tryParse(json['date']) ?? DateTime.now(),
      hour: json['hour'],
      place: json['place'],
      description: json['description'],
      confirmByPatient: json['patientConfirm'],
      confirmByEspetialist: json['specialistConfirm'],
      patient:
          isPatient ? null : PatientModel.fromJson(json['patient'], isPatient),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date!.toIso8601String(),
      'hour': hour,
      'place': place,
      'description': description,
    };
  }
}

class GoalwithDate {
  final int id;
  final GoalModel? goal;

  GoalwithDate({
    required this.id,
    this.goal,
  });

  GoalwithDate copyWith({
    int? id,
    GoalModel? goal,
  }) {
    return GoalwithDate(
      id: id ?? this.id,
      goal: goal ?? this.goal,
    );
  }

  factory GoalwithDate.fromJson(Map<String, dynamic> json) {
    return GoalwithDate(
      id: json['dateId'],
      goal: json['goal'] != null ? GoalModel.fromJson(json['goal']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateId': id,
      'goal': goal,
    };
  }
}
