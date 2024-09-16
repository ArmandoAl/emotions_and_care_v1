import '../../../helpers/paths.dart';

abstract class ICartRepository {
  Future<GoalWithCart> addCart(
      CartModel cart, int idUser, bool isPatient, bool isFirstTime);

  Future<bool> deleteCart(int idCart);

  Future<bool> updateCart(CartModel cart);

  Future<List<CartModel>> getCartList(int idUser, bool isPatient);

  Future<CartModel> getCart(int idCart);

  Future<GoalWithResponseCart> addResponse(
      CartResponse cartResponse, int idCart, bool isFirstTime);

  Future<List<CartModel>> initCommunity(int userId);
}
