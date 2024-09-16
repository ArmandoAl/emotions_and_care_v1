import '../../../helpers/paths.dart';

class DateModel {
  final int? id;
  final DateTime date;
  final String hour;
  final String place;
  final String description;
  bool confirmByPatient;
  bool confirmByEspetialist;
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
      id: json['idCita'],
      date: DateTime.parse(json['fecha']),
      hour: json['hora'],
      place: json['lugar'],
      description: json['descripcion'],
      confirmByPatient: json['confirmadaPorPaciente'],
      confirmByEspetialist: json['confirmadaPorEspecialista'],
      patient:
          isPatient ? null : PatientModel.fromJson(json['paciente'], false),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Fecha': date.toIso8601String(),
      'Hora': hour,
      'Lugar': place,
      'Descripcion': description,
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
      id: json['idCita'],
      goal: json['logro'] != null ? GoalModel.fromJson(json['logro']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCita': id,
      'logro': goal,
    };
  }
}
