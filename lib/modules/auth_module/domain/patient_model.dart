import '../../../helpers/paths.dart';

class PatientModel extends UserModel {
  SpecialistModel? specialist;
  PattientSettings? settings;
  String registerStatus = "";
  UserInterface? userInterface;

  PatientModel(
      {this.specialist,
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
      this.registerStatus = "",
      this.userInterface});

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
    String? registerStatus,
    DateTime? bornDate,
    UserInterface? userInterface,
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
      registerStatus: registerStatus ?? this.registerStatus,
      userInterface: userInterface ?? this.userInterface,
    );
  }

  factory PatientModel.fromJson(Map<String, dynamic> json, bool isPatient) {
    return PatientModel(
      specialist: isPatient
          ? json['specialist'] != null
              ? SpecialistModel.fromJson(json['specialist'])
              : null
          : null,
      id: json['userId'],
      name: json['name'],
      email: json['mail'],
      password: isPatient ? json['password'] : '',
      phone: json['phone'],
      age: json['age'],
      bornDate: DateTime.tryParse(json['bornDate'] ?? ""),
      sex: json['sex'],
      token: json['token'],
      tokenForRelate: json['relationalToken'],
      termsClass: json['termsAndConditions'] == null
          ? null
          : TermAndConditions.fromJson(
              json['termsAndConditions'],
            ),
      settings: json['settings'] == null
          ? null
          : PattientSettings.fromJson(json['settings']),
      type: UserType.patient,
      registerStatus: json["registerState"] ?? "",
      userInterface: json['userInterface'] == null
          ? null
          : UserInterface.fromJson(json['userInterface']),
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
      "relationalToken": tokenForRelate,
      // "settings": settings!.toJson(),
      "termsAndConditions": termsClass!.toJson(),
      "specialist": specialist?.toStore(),
      "registerStatus": registerStatus,
      "userInterface": userInterface?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mail': email,
      'password': password,
      'phone': phone,
      'bornDate': bornDate!.toIso8601String(),
      'sex': sex,
      'token': token,
      "termsiD": 1,
    };
  }
}

class UserInterface {
  final int? userInterfaceId;

  final List<UserFlower>? userFlowers;

  final List<UserSticker>? userStickers;

  final int? backgroundUrl;

  final int? themeId;

  UserInterface(
      {this.userInterfaceId,
      this.userFlowers,
      this.userStickers,
      this.backgroundUrl,
      this.themeId});

  //copyWith
  UserInterface copyWith({
    int? userInterfaceId,
    List<UserFlower>? userFlowers,
    List<UserSticker>? userStickers,
    int? backgroundUrl,
    int? themeId,
  }) {
    return UserInterface(
      userInterfaceId: userInterfaceId ?? this.userInterfaceId,
      userFlowers: userFlowers ?? this.userFlowers,
      userStickers: userStickers ?? this.userStickers,
      backgroundUrl: backgroundUrl ?? this.backgroundUrl,
      themeId: themeId ?? this.themeId,
    );
  }

  factory UserInterface.fromJson(Map<String, dynamic> json) {
    return UserInterface(
      userInterfaceId: json['userInterfaceId'],
      userFlowers: (json['userFlowers'] as List)
          .map((e) => UserFlower.fromJson(e))
          .toList(),
      userStickers: (json['userStickers'] as List)
          .map((e) => UserSticker.fromJson(e))
          .toList(),
      backgroundUrl: json['backgroundUrl'],
      themeId: json['themeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userInterfaceId': userInterfaceId,
      'userFlowers': userFlowers!.map((e) => e.toJson()).toList(),
      'userStickers': userStickers!.map((e) => e.toJson()).toList(),
      'backgroundUrl': backgroundUrl,
      'themeId': themeId,
    };
  }
}

class UserFlower {
  final int userFlowerId;
  final FlowerModel flower;
  final int state;
  final int? position;

  UserFlower({
    required this.userFlowerId,
    required this.flower,
    required this.state,
    this.position,
  });

  UserFlower copyWith({
    int? userFlowerId,
    FlowerModel? flower,
    int? state,
    int? position,
  }) {
    return UserFlower(
      userFlowerId: userFlowerId ?? this.userFlowerId,
      flower: flower ?? this.flower,
      state: state ?? this.state,
      position: position ?? this.position,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userFlowerId': flower.id,
      'flower': flower.toJson(),
      'state': state,
      'position': position,
    };
  }

  factory UserFlower.fromJson(Map<String, dynamic> json) {
    return UserFlower(
      userFlowerId: json['userFlowerId'] ?? 0,
      flower: FlowerModel.fromJson(json['flower']),
      state: json['state'] ?? 0,
      position: json['position'] ?? 0,
    );
  }
}

class UserSticker {
  final int userStickerId;
  final StickerModel sticker;
  final int? position;

  UserSticker({
    required this.userStickerId,
    required this.sticker,
    this.position,
  });

  UserSticker copyWith({
    int? userStickerId,
    StickerModel? sticker,
    int? position,
  }) {
    return UserSticker(
      userStickerId: userStickerId ?? this.userStickerId,
      sticker: sticker ?? this.sticker,
      position: position ?? this.position,
    );
  }

  UserSticker empty() {
    return UserSticker(
      userStickerId: -1,
      sticker: StickerModel.empty(),
      position: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userStickerId': userStickerId,
      'sticker': sticker.toJson(),
      'position': position,
    };
  }

  factory UserSticker.fromJson(Map<String, dynamic> json) {
    return UserSticker(
      userStickerId: json['userStickerId'],
      sticker: StickerModel.fromJson(json['sticker']),
      position: json['position'],
    );
  }
}
