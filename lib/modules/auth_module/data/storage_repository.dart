import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helpers/paths.dart';

class StorageRepository {
  final SharedPreferences sharedPreferences;

  StorageRepository({required this.sharedPreferences});

  Future<void> savePatient(PatientModel patient) async {
    final sharedPreferencesF = sharedPreferences;
    sharedPreferencesF.setString('user', jsonEncode(patient.toStore()));
  }

  Future<void> saveSpecialist(SpecialistModel specialist) async {
    final sharedPreferencesF = sharedPreferences;
    sharedPreferencesF.setString('user', jsonEncode(specialist.toStore()));
  }

  Future<String?> getUser() async {
    final sharedPreferencesF = sharedPreferences;
    return sharedPreferencesF.getString('user');
  }

  Future<void> removeUser() async {
    final sharedPreferencesF = sharedPreferences;
    sharedPreferencesF.remove('user');
  }

  void clean() {
    final sharedPreferencesF = sharedPreferences;
    sharedPreferencesF.clear();
  }

  Future<void> saveRegisterPatientFlow(String status) async {
    final sharedPreferencesF = sharedPreferences;
    sharedPreferencesF.setString('registerPatientFlow', status);
  }

  Future<String?> getRegisterPatientFlow() async {
    final sharedPreferencesF = sharedPreferences;
    return sharedPreferencesF.getString('registerPatientFlow');
  }

  Future<void> saveStickersInUse(List<StickerModel> stickersInUse) async {
    final sharedPreferencesF = sharedPreferences;
    sharedPreferencesF.setString('stickersInUse', jsonEncode(stickersInUse));
  }

  Future<List<StickerModel>> getStickersInUse() async {
    final sharedPreferencesF = sharedPreferences;
    final stickersInUse = sharedPreferencesF.getString('stickersInUse');
    if (stickersInUse == null) {
      return [];
    }
    return (jsonDecode(stickersInUse) as List)
        .map((e) => StickerModel.fromJson(e))
        .toList();
  }

  Future<void> saveStickers(List<StickerModel> stickers) async {
    final sharedPreferencesF = sharedPreferences;
    sharedPreferencesF.setString('stickers', jsonEncode(stickers));
  }

  Future<List<StickerModel>> getStickers() async {
    final sharedPreferencesF = sharedPreferences;
    final stickers = sharedPreferencesF.getString('stickers');
    if (stickers == null) {
      return [];
    }
    return (jsonDecode(stickers) as List)
        .map((e) => StickerModel.fromJson(e))
        .toList();
  }

  Future<FlowerModel?> getCurrentFlower() async {
    final sharedPreferencesF = sharedPreferences;
    final currentFlower = sharedPreferencesF.getString('currentFlower');
    if (currentFlower == null) {
      return null;
    }
    return FlowerModel.fromJson(jsonDecode(currentFlower));
  }

  Future<void> saveCurrentFlower(FlowerModel flower) async {
    final sharedPreferencesF = sharedPreferences;
    sharedPreferencesF.setString('currentFlower', jsonEncode(flower));
  }

  Future<List<FlowerModel>> getFlowers() async {
    final sharedPreferencesF = sharedPreferences;
    final flowers = sharedPreferencesF.getString('flowers');
    if (flowers == null) {
      return [];
    }
    return (jsonDecode(flowers) as List)
        .map((e) => FlowerModel.fromJson(e))
        .toList();
  }

  Future<void> saveFlowers(List<FlowerModel> flowers) async {
    final sharedPreferencesF = sharedPreferences;
    sharedPreferencesF.setString('flowers', jsonEncode(flowers));
  }

  Future<String?> getSelectedBackground() async {
    final sharedPreferencesF = sharedPreferences;
    return sharedPreferencesF.getString('selectedBackground');
  }

  Future<void> saveSelectedBackground(String background) async {
    final sharedPreferencesF = sharedPreferences;
    sharedPreferencesF.setString('selectedBackground', background);
  }

  Future<int?> getSelectedTheme() async {
    final sharedPreferencesF = sharedPreferences;
    return sharedPreferencesF.getInt('selectedTheme');
  }

  Future<void> saveSelectedTheme(int index) async {
    final sharedPreferencesF = sharedPreferences;
    sharedPreferencesF.setInt('selectedTheme', index);
  }
}
