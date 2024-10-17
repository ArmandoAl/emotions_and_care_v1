import '../../../helpers/paths.dart';

enum EstadoCarta { enviada, expirada }

class CartModel {
  int? id;
  int idEmisor;
  String letraEmisor;
  String contenido;
  EstadoCarta estado;
  List<CartResponse>? respuestas;
  bool visible = false;

  CartModel({
    this.id,
    required this.idEmisor,
    required this.letraEmisor,
    required this.contenido,
    this.estado = EstadoCarta.enviada,
    this.respuestas,
  });

  CartModel copyWith({
    int? id,
    int? idEmisor,
    String? letraEmisor,
    String? contenido,
    EstadoCarta? estado,
    List<CartResponse>? respuestas,
  }) {
    return CartModel(
      id: id ?? this.id,
      idEmisor: idEmisor ?? this.idEmisor,
      letraEmisor: letraEmisor ?? this.letraEmisor,
      contenido: contenido ?? this.contenido,
      estado: estado ?? this.estado,
      respuestas: respuestas ?? this.respuestas,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transmitterId': idEmisor,
      'transmitterInitial': letraEmisor,
      'content': contenido,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['cartId'],
      idEmisor: json['transmitterId'],
      letraEmisor: json['transmitterInitial'],
      contenido: json['content'],
      estado: EstadoCarta.values[json['state']],
      respuestas: List<CartResponse>.from(
          json['cartAnswers']?.map((x) => CartResponse.fromJson(x))),
    );
  }
}

class GoalWithCart {
  final int id;
  final GoalModel? goalModel;

  GoalWithCart({
    required this.id,
    required this.goalModel,
  });

  GoalWithCart copyWith({
    int? id,
    GoalModel? goalModel,
  }) {
    return GoalWithCart(
      id: id ?? this.id,
      goalModel: goalModel ?? this.goalModel,
    );
  }

  factory GoalWithCart.fromJson(Map<String, dynamic> json) {
    return GoalWithCart(
      id: json['cartId'],
      goalModel: json['goal'] != null ? GoalModel.fromJson(json['goal']) : null,
    );
  }
}
