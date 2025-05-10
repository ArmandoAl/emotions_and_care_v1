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
      id: json['userId'],
      name: json['name'],
      email: json['mail'],
      password: json['password'],
      phone: json['phone'],
      age: json['age'],
      sex: json['sex'],
      token: json['token'],
      tokenForRelate: json['relationalToken'],
      termsClass: TermAndConditions.fromJson(json['termsAndConditions']),
      bornDate:
          (DateTime.tryParse(json['bornDate']) ?? DateTime.now()).toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'name': name,
      'mail': email,
      'password': password,
      'phone': phone,
      'age': age,
      'sex': sex,
      'token': token,
      'bornDate': bornDate!.toIso8601String(),
      'relationalToken': tokenForRelate,
      'termsAndConditions': termsClass!.toJson(),
    };
  }
}
