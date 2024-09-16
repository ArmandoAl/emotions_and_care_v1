import '../../../helpers/paths.dart';

class DateRequestModel {
  int id;
  DateModel date;

  DateRequestModel({required this.id, required this.date});

  factory DateRequestModel.fromJson(Map<String, dynamic> json) {
    return DateRequestModel(
      id: json['idSolicitudCita'],
      date: DateModel.fromJson(json['cita'], false),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toJson(),
    };
  }

  DateRequestModel copyWith({
    int? id,
    DateModel? date,
  }) {
    return DateRequestModel(
      id: id ?? this.id,
      date: date ?? this.date,
    );
  }
}
