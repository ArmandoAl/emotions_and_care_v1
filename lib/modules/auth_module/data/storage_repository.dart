import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helpers/paths.dart';
import '../../../helpers/user_provider.dart';

class StorageRepository {
  final Future<SharedPreferences> _sharedPreferences;

  StorageRepository(this._sharedPreferences);

  Future<void> savePatient(PatientModel patient) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString('user', jsonEncode(patient.toStore()));
  }

  Future<void> saveSpecialist(SpecialistModel specialist) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString('user', jsonEncode(specialist.toStore()));
  }

  Future<String?> getUser() async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString('user');
  }

  Future<void> removeUser() async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.remove('user');
  }

  Future<void> clean() async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.clear();
  }

  Future<void> saveRegisterPatientFlow(
      RegisterPatientFlow registerPatientFlow) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString(
        'registerPatientFlow', registerPatientFlow.toString());
  }

  Future<String?> getRegisterPatientFlow() async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString('registerPatientFlow');
  }

  Future<void> saveStickersInUse(List<StickerModel> stickersInUse) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString('stickersInUse', jsonEncode(stickersInUse));
  }

  Future<List<StickerModel>> getStickersInUse() async {
    final sharedPreferences = await _sharedPreferences;
    final stickersInUse = sharedPreferences.getString('stickersInUse');
    if (stickersInUse == null) {
      return [];
    }
    return (jsonDecode(stickersInUse) as List)
        .map((e) => StickerModel.fromJson(e))
        .toList();
  }

  Future<void> saveStickers(List<StickerModel> stickers) async {
    print(stickers);
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString('stickers', jsonEncode(stickers));
  }

  Future<List<StickerModel>> getStickers() async {
    print('getStickers');
    final sharedPreferences = await _sharedPreferences;
    final stickers = sharedPreferences.getString('stickers');
    if (stickers == null) {
      return [];
    }
    return (jsonDecode(stickers) as List)
        .map((e) => StickerModel.fromJson(e))
        .toList();
  }

  Future<FlowerModel?> getCurrentFlower() async {
    final sharedPreferences = await _sharedPreferences;
    final currentFlower = sharedPreferences.getString('currentFlower');
    if (currentFlower == null) {
      return null;
    }
    return FlowerModel.fromJson(jsonDecode(currentFlower));
  }

  Future<void> saveCurrentFlower(FlowerModel flower) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString('currentFlower', jsonEncode(flower));
  }

  Future<List<FlowerModel>> getFlowers() async {
    final sharedPreferences = await _sharedPreferences;
    final flowers = sharedPreferences.getString('flowers');
    if (flowers == null) {
      return [];
    }
    return (jsonDecode(flowers) as List)
        .map((e) => FlowerModel.fromJson(e))
        .toList();
  }

  Future<void> saveFlowers(List<FlowerModel> flowers) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString('flowers', jsonEncode(flowers));
  }

  Future<String?> getSelectedBackground() async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString('selectedBackground');
  }

  Future<void> saveSelectedBackground(String background) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString('selectedBackground', background);
  }

  Future<int?> getSelectedTheme() async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getInt('selectedTheme');
  }

  Future<void> saveSelectedTheme(int index) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setInt('selectedTheme', index);
  }
}
