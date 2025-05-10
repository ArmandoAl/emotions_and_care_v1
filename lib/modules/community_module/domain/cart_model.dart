import '../../../helpers/paths.dart';

enum EstadoCarta { enviada, expirada }

class CartModel {
  int? id;
  int idEmisor;
  String letraEmisor;
  String contenido;
  EstadoCarta estado;
  List<CartResponse> respuestas;
  bool visible;
  DateTime? fechaCreacion = DateTime.now();

  CartModel(
      {this.id,
      required this.idEmisor,
      required this.letraEmisor,
      required this.contenido,
      this.estado = EstadoCarta.enviada,
      this.respuestas = const [],
      this.visible = false,
      this.fechaCreacion});

  CartModel copyWith({
    int? id,
    int? idEmisor,
    String? letraEmisor,
    String? contenido,
    EstadoCarta? estado,
    List<CartResponse>? respuestas,
    bool? visible,
    DateTime? fechaCreacion,
  }) {
    return CartModel(
      id: id ?? this.id,
      idEmisor: idEmisor ?? this.idEmisor,
      letraEmisor: letraEmisor ?? this.letraEmisor,
      contenido: contenido ?? this.contenido,
      estado: estado ?? this.estado,
      respuestas: respuestas ?? this.respuestas,
      visible: visible ?? this.visible,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
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
      fechaCreacion:
          (DateTime.tryParse(json['dateCreated']) ?? DateTime.now()).toLocal(),
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

class CartWithAchivement {
  final int id;
  final int? achivementId;

  CartWithAchivement({
    required this.id,
    required this.achivementId,
  });

  CartWithAchivement copyWith({
    int? id,
    int? achivementId,
  }) {
    return CartWithAchivement(
      id: id ?? this.id,
      achivementId: achivementId ?? this.achivementId,
    );
  }

  factory CartWithAchivement.fromJson(Map<String, dynamic> json) {
    return CartWithAchivement(
      id: json['cartId'] ?? 0,
      achivementId: json['achievementId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartId': id,
      'achievementId': achivementId,
    };
  }
}
