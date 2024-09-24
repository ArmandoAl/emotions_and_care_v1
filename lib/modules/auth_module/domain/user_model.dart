import '../../../helpers/paths.dart';

enum UserType { patient, specialist }

class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  int? age;
  String? sex;
  String? token;
  String? tokenForRelate;
  TermAndConditions? termsClass;
  UserType? type;
  DateTime? bornDate;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.age,
    this.sex,
    this.token,
    this.tokenForRelate,
    this.termsClass,
    this.bornDate,
    this.type = UserType.patient,
  });

  UserModel copyWith({
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
    DateTime? bornDate,
    UserType? type,
  }) {
    return UserModel(
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
      bornDate: bornDate ?? this.bornDate,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['IdUsuario'],
      name: json['Nombre'],
      email: json['Correo'],
      password: json['Contrasena'],
      phone: json['Telefono'],
      age: json['Edad'],
      sex: json['Sexo'],
      token: json['Token'],
      tokenForRelate: json['TokenRelacional'],
      termsClass: TermAndConditions.fromJson(json['Terminosycondiciones']),
      bornDate: DateTime.parse(json['fechaNacimiento']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'IdUsuario': id,
      'Nombre': name,
      'Correo': email,
      'Contrasena': password,
      'Telefono': phone,
      'Edad': age,
      'Sexo': sex,
      'Token': token,
      'fechaNacimiento': token,
      'TokenRelacional': tokenForRelate,
      'Terminosycondiciones': termsClass!.toJson(),
    };
  }
}
