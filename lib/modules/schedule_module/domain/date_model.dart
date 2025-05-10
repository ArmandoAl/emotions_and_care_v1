import '../../../helpers/paths.dart';

enum DateStatus { initial, confirmed, completed, notCompleted, pendingToMatch }

class DateModel {
  final int? id;
  final DateTime? date;
  final String? hour;
  final String? place;
  final String? description;
  bool? confirmByPatient;
  bool? confirmByEspetialist;
  PatientModel? patient;
  bool? done;
  String? specialistNotes;
  DateStatus? status;
  bool? sentBySpecialist;

  DateModel({
    this.id,
    required this.date,
    required this.hour,
    required this.place,
    required this.description,
    required this.confirmByPatient,
    required this.confirmByEspetialist,
    this.patient,
    this.done = false,
    this.specialistNotes = '',
    this.status = DateStatus.initial,
    this.sentBySpecialist = false,
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
    bool? done,
    String? specialistNotes,
    DateStatus? status,
    bool? sentBySpecialist,
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
      done: done ?? this.done,
      specialistNotes: specialistNotes ?? this.specialistNotes,
      status: status ?? this.status,
      sentBySpecialist: sentBySpecialist ?? this.sentBySpecialist,
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
      done: json['done'],
      specialistNotes: json['specialistNotes'],
      status: DateStatus.values[json['status']],
      sentBySpecialist: json['sentBySpecialist'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date!.toIso8601String(),
      "hour": hour,
      "place": place,
      "description": description,
      "specialistNotes": specialistNotes,
      "patientConfirm": confirmByPatient,
      "specialistConfirm": confirmByEspetialist,
      "done": done,
      "status": status!.index,
      "sentBySpecialist": sentBySpecialist,
    };
  }

  Map<String, dynamic> toPutJson() {
    return {
      'dateId': id,
      "date": date!.toIso8601String(),
      "hour": hour,
      "place": place,
      "description": description,
      "specialistNotes": specialistNotes,
      "patientConfirm": confirmByPatient,
      "specialistConfirm": confirmByEspetialist,
      "done": done,
      "status": status!.index,
      "sentBySpecialist": sentBySpecialist,
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

class DateWithAchivement {
  final int id;
  final int? achivementId;

  DateWithAchivement({
    required this.id,
    this.achivementId,
  });

  DateWithAchivement copyWith({
    int? id,
    int? achivementId,
  }) {
    return DateWithAchivement(
      id: id ?? this.id,
      achivementId: achivementId ?? this.achivementId,
    );
  }

  factory DateWithAchivement.fromJson(Map<String, dynamic> json) {
    return DateWithAchivement(
      id: json['dateId'] ?? 0,
      achivementId: json['achievementId'],
    );
  }
}
