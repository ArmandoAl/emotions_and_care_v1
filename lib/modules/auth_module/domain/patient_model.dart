import '../../../helpers/paths.dart';

class PatientModel extends UserModel {
  SpecialistModel? specialist;
  PattientSettings? settings;
  bool registerSet = false;

  PatientModel({
    this.specialist,
    super.id,
    super.name,
    super.email,
    super.password,
    super.phone,
    super.age = 0,
    super.bornDate,
    super.sex,
    super.token,
    super.tokenForRelate,
    super.termsClass,
    this.settings,
    super.type,
    this.registerSet = false,
  });

  @override
  PatientModel copyWith({
    SpecialistModel? specialist,
    int? id,
    String? name,
    String? email,
    String? password,
    String? phone,
    int? age,
    String? sex,
    String? token,
    String? tokenForRelate,
    TermAndConditions? termsClass,
    PattientSettings? settings,
    UserType? type,
    bool? registerSet,
    DateTime? bornDate,
  }) {
    return PatientModel(
      specialist: specialist ?? this.specialist,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      age: age ?? this.age,
      bornDate: bornDate ?? this.bornDate,
      sex: sex ?? this.sex,
      token: token ?? this.token,
      tokenForRelate: tokenForRelate ?? this.tokenForRelate,
      termsClass: termsClass ?? this.termsClass,
      settings: settings ?? this.settings,
      type: type ?? this.type,
      registerSet: registerSet ?? this.registerSet,
    );
  }

  factory PatientModel.fromJson(Map<String, dynamic> json, bool isPatient) {
    return PatientModel(
      specialist: isPatient
          ? json['especialista'] != null
              ? SpecialistModel.fromJson(json['especialista'])
              : null
          : null,
      id: json['idUsuario'],
      name: json['nombre'],
      email: json['correo'],
      password: isPatient ? json['contraseña'] : '',
      phone: json['telefono'],
      age: json['edad'],
      bornDate: DateTime.parse(json['fechaNacimiento']),
      sex: json['sexo'],
      token: json['token'],
      tokenForRelate: json['tokenRelacional'],
      termsClass: TermAndConditions.fromJson(
        json['terminosycondiciones'],
      ),
      settings: PattientSettings.fromJson(json['configuracion']),
      type: UserType.patient,
      registerSet: json["registerSet"],
    );
  }

  Map<String, dynamic> toStore() {
    return {
      'idUsuario': id,
      'nombre': name,
      'correo': email,
      'contraseña': password,
      'telefono': phone,
      'edad': age,
      'fechaNacimiento': bornDate!.toIso8601String(),
      'sexo': sex,
      'token': token,
      "tokenRelacional": tokenForRelate,
      "configuracion": settings!.toJson(),
      "terminosycondiciones": termsClass!.toJson(),
      "especialista": specialist?.toStore(),
      "registerSet": registerSet,
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'nombre': name,
      'correo': email,
      'contraseña': password,
      'telefono': phone,
      'fechaNacimiento': bornDate!.toIso8601String(),
      'sexo': sex,
      'token': token,
      "TerminosycondicionesId": 1,
    };
  }
}
