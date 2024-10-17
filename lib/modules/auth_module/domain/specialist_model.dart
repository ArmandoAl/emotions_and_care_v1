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
      professionalLicense: json['license'],
      patients: [],
      id: json['userId'],
      name: json['name'],
      email: json['mail'],
      password: json['password'],
      phone: json['phone'],
      age: json['age'],
      bornDate: DateTime.parse(json['bornDate']),
      sex: json['sex'],
      token: json['token'],
      tokenForRelate: json['relationalToken'],
      termsClass: TermAndConditions.fromJson(json['termsAndConditions']),
      focus: json['focus'],
      institution: json['institution'],
      ubication: json['adress'],
      presentation: json['presentation'],
      type: UserType.specialist,
    );
  }

  Map<String, dynamic> toStore() {
    return {
      'userId': id,
      'name': name,
      'mail': email,
      'password': password,
      'phone': phone,
      'age': age,
      'bornDate': bornDate!.toIso8601String(),
      'sex': sex,
      'token': token,
      'relationalToken': tokenForRelate,
      'license': professionalLicense,
      'termsAndConditions': termsClass!.toJson(),
      'focus': focus,
      'institution': institution,
      'adress': ubication,
      'presentation': presentation,
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mail': email,
      'password': password,
      'phone': phone,
      'age': age,
      'sex': sex,
      'token': phone! + token!,
      'termsiD': 2,
      'license  ': professionalLicense,
      'focus': focus ?? '',
      'institution': institution ?? '',
      'adress': ubication ?? '',
      'presentation': presentation ?? '',
    };
  }
}
