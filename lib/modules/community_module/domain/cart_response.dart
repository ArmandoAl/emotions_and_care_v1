import '../../../helpers/paths.dart';

class CartResponse {
  int? id;
  int idReceptor;
  String letraReceptor;
  String contenido;
  int? idSticker;
  bool leida;

  CartResponse({
    required this.id,
    required this.idReceptor,
    required this.letraReceptor,
    required this.contenido,
    this.idSticker,
    required this.leida,
  });

  CartResponse copyWith({
    int? id,
    int? idReceptor,
    String? letraReceptor,
    String? contenido,
    int? idSticker,
    bool? leida,
  }) {
    return CartResponse(
      id: id ?? this.id,
      idReceptor: idReceptor ?? this.idReceptor,
      letraReceptor: letraReceptor ?? this.letraReceptor,
      contenido: contenido ?? this.contenido,
      idSticker: idSticker ?? this.idSticker,
      leida: leida ?? this.leida,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'receiverId': idReceptor,
      'receiverInitial': letraReceptor,
      'content': contenido,
      'read': leida,
    };
  }

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      id: json['cartId'],
      idReceptor: json['receiverId'],
      letraReceptor: json['receiverInitial'],
      contenido: json['content'],
      idSticker: json['stickerId'],
      leida: json['read'],
    );
  }
}

class GoalWithResponseCart {
  final int id;
  final GoalModel? goalModel;

  GoalWithResponseCart({
    required this.id,
    required this.goalModel,
  });

  GoalWithResponseCart copyWith({
    int? id,
    GoalModel? goalModel,
  }) {
    return GoalWithResponseCart(
      id: id ?? this.id,
      goalModel: goalModel ?? this.goalModel,
    );
  }

  factory GoalWithResponseCart.fromJson(Map<String, dynamic> json) {
    return GoalWithResponseCart(
      id: json['idRespuestaCarta'],
      goalModel: json['logro'],
    );
  }
}
