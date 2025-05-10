import 'dart:convert';
import 'package:emotions_and_care_v1/modules/auth_module/domain/progress.dart';

import '../../../helpers/paths.dart';
import 'package:http/http.dart' as http;

abstract class UIRepository {
  Future<StickerModel> getSticker(int id);

  Future<void> setStickerInInterface(
      int idpatient, StickerModel sticker, int index);

  Future<void> setFlowerInInterface(
      int idpatient, UserFlower flower, int position);

  Future<void> removeSticker(int idpatient, StickerModel sticker, int position);

  Future<void> setTheme(int idpatient, int theme);

  Future<void> setSelectedBackground(int idpatient, int background);

  Future<List<AppText>> getTexts();

  Future<List<ProgressInfo>> getStagesProgress(int idpatient);
}

class UIRepositoryImpl extends UIRepository {
  @override
  Future<StickerModel> getSticker(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Items/GetSticker/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add note');
      }

      return StickerModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to add note');
    }
  }

  @override
  Future<void> setStickerInInterface(
      int idpatient, StickerModel sticker, int index) async {
    try {
      final response = await http.put(
        Uri.parse(
            '${Api.baseUrl}Paciente/$idpatient/putStickeriInInterface/${sticker.id}/$index'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to set sticker in interface');
      }
    } catch (e) {
      throw Exception('Failed to set sticker in interface');
    }
  }

  @override
  Future<void> setFlowerInInterface(
      int idpatient, UserFlower flower, int position) async {
    try {
      final response = await http.put(
        Uri.parse(
            '${Api.baseUrl}Paciente/$idpatient/putFlowerInInterface/${flower.flower.id}/2'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to set flower in interface');
      }
    } catch (e) {
      throw Exception('Failed to set flower in interface');
    }
  }

  @override
  Future<void> removeSticker(
      int idpatient, StickerModel sticker, int position) async {
    try {
      final response = await http.put(
        Uri.parse(
            '${Api.baseUrl}Paciente/$idpatient/removeStickerInInterface/$position'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to remove sticker');
      }
    } catch (e) {
      throw Exception('Failed to remove sticker');
    }
  }

  @override
  Future<void> setTheme(int idpatient, int theme) async {
    try {
      final response = await http.put(
        Uri.parse('${Api.baseUrl}Paciente/$idpatient/actualizarThemeId/$theme'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to set theme');
      }
    } catch (e) {
      throw Exception('Failed to set theme');
    }
  }

  @override
  Future<void> setSelectedBackground(int idpatient, int background) async {
    try {
      final response = await http.put(
        Uri.parse(
            '${Api.baseUrl}Paciente/$idpatient/actualizarBackgroundUrl/${background + 1}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to set background');
      }
    } catch (e) {
      throw Exception('Failed to set background');
    }
  }

  @override
  Future<List<AppText>> getTexts() async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Texts/GET-ALL'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        return [];
      }

      List<AppText> texts = [];
      for (var item in jsonDecode(response.body)) {
        texts.add(AppText.fromJson(item));
      }
      return texts;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<ProgressInfo>> getStagesProgress(int idpatient) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Paciente/$idpatient/getStageProgress'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        return [];
      }

      List<ProgressInfo> stages = [];
      for (var item in jsonDecode(response.body)) {
        stages.add(ProgressInfo.fromJson(item));
      }
      return stages;
    } catch (e) {
      return [];
    }
  }
}
