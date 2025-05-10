import '../../../helpers/paths.dart';

abstract class ICartRepository {
  Future<CartWithAchivement> addCart(
      CartModel cart, int idUser, bool isPatient);

  Future<bool> deleteCart(int idCart);

  Future<bool> updateCart(CartModel cart);

  Future<List<CartModel>> getCartList(int idUser, bool isPatient);

  Future<CartModel> getCart(int idCart);

  Future<ResponseWithAchivement> addResponse(
      CartResponse cartResponse, int idCart);

  Future<List<CartModel>> initCommunity(int userId);
}
