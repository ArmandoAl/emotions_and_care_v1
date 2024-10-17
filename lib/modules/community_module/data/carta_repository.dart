import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../helpers/paths.dart';

class CartRepository extends ICartRepository {
  @override
  Future<GoalWithCart> addCart(
      CartModel cart, int idUser, bool isPatient, bool isFirstTime) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${Api.baseUrl}Carta/$idUser/AgregarCarta/$isPatient/$isFirstTime'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(cart.toJson()),
      );

      print(response.body);

      if (response.statusCode != 200) {
        throw Exception('Failed to add note');
      }

      return GoalWithCart.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to add note');
    }
  }

  @override
  Future<bool> deleteCart(int idCart) async {
    try {
      final response = await http.delete(
        Uri.parse('${Api.baseUrl}Carta/$idCart'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        return false;
      }

      return true;
    } catch (e) {
      throw Exception('Failed to delete note');
    }
  }

  @override
  Future<bool> updateCart(CartModel cart) async {
    try {
      final response = await http.put(
        Uri.parse('${Api.baseUrl}Carta'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(cart.toJson()),
      );

      if (response.statusCode != 200) {
        return false;
      }

      return true;
    } catch (e) {
      throw Exception('Failed to update note');
    }
  }

  @override
  Future<List<CartModel>> getCartList(int idUser, bool isPatient) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Carta/$idUser/Cartas/$isPatient'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        return [];
      }

      return (jsonDecode(response.body) as List)
          .map((e) => CartModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to load notes');
    }
  }

  @override
  Future<CartModel> getCart(int idCart) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Carta/$idCart'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load note');
      }

      return CartModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to load note');
    }
  }

  @override
  Future<GoalWithResponseCart> addResponse(
      CartResponse cartResponse, int idCart, bool isFirstTime) async {
    try {
      final response = await http.post(
        Uri.parse('${Api.baseUrl}Carta/$idCart/AgregarRespuesta/$isFirstTime'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(cartResponse.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add response');
      }

      return GoalWithResponseCart.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to add response');
    }
  }

  @override
  Future<List<CartModel>> initCommunity(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}Carta/$userId/initCarts'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        return [];
      }

      return (jsonDecode(response.body) as List)
          .map((e) => CartModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to load notes');
    }
  }
}
