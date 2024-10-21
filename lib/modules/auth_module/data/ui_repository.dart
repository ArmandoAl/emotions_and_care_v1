import 'dart:convert';
import '../../../helpers/paths.dart';
import 'package:http/http.dart' as http;

abstract class UIRepository {
  Future<StickerModel> getSticker(int id);

  Future<void> setStickerInInterface(
      int idpatient, StickerModel sticker, int index);
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
}
