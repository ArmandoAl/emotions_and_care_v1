import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../helpers/paths.dart';

class TermsRepository implements ITermsRepository {
  @override
  Future<String> getTerms(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Terminos/${id + 1}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load terms');
      }

      final data = jsonDecode(response.body);
      return data['termsAndConditions'];
    } catch (e) {
      throw Exception('Failed to load terms');
    }
  }
}
