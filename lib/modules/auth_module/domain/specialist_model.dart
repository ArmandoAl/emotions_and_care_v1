import '../../../helpers/paths.dart';

class SpecialistModel extends UserModel {
  String? professionalLicense;
  String? focus;
  String? institution;
  String? ubication;
  String? presentation;

  List<PatientModel>? patients;

  SpecialistModel({
    this.professionalLicense,
    this.patients,
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
    super.type,
    this.focus,
    this.institution,
    this.ubication,
    this.presentation,
  });

  @override
  SpecialistModel copyWith({
    String? professionalLicense,
    List<PatientModel>? patients,
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
    UserType? type,
    String? focus,
    String? institution,
    String? ubication,
    String? presentation,
    DateTime? bornDate,
  }) {
    return SpecialistModel(
      professionalLicense: professionalLicense ?? this.professionalLicense,
      patients: patients ?? this.patients,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      token: token ?? this.token,
      tokenForRelate: tokenForRelate ?? this.tokenForRelate,
      termsClass: termsClass ?? this.termsClass,
      type: type ?? this.type,
      focus: focus ?? this.focus,
      institution: institution ?? this.institution,
      ubication: ubication ?? this.ubication,
      presentation: presentation ?? this.presentation,
      bornDate: bornDate ?? this.bornDate,
    );
  }

  factory SpecialistModel.fromJson(Map<String, dynamic> json) {
    return SpecialistModel(
      professionalLicense: json['cedulaProfesional'],
      patients: [],
      id: json['idUsuario'],
      name: json['nombre'],
      email: json['correo'],
      password: json['contraseña'],
      phone: json['telefono'],
      age: json['edad'],
      bornDate: DateTime.parse(json['fechaNacimiento']),
      sex: json['sexo'],
      token: json['token'],
      tokenForRelate: json['tokenRelacional'],
      termsClass: TermAndConditions.fromJson(json['terminosycondiciones']),
      focus: json['enfoque'],
      institution: json['institucion'],
      ubication: json['ubicaion'],
      presentation: json['presentacion'],
      type: UserType.specialist,
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
      'tokenRelacional': tokenForRelate,
      'cedulaProfesional': professionalLicense,
      'terminosycondiciones': termsClass!.toJson(),
      'enfoque': focus,
      'institucion': institution,
      'ubicaion': ubication,
      'presentacion': presentation,
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'nombre': name,
      'correo': email,
      'contraseña': password,
      'telefono': phone,
      'edad': age,
      'sexo': sex,
      'token': phone! + token!,
      'TerminosycondicionesId': 2,
      'cedulaProfesional': professionalLicense,
      'especialidad': institution ?? '',
      'institucion': focus,
      'ubicaion': ubication ?? '',
      'presentacion': presentation ?? '',
    };
  }
}
