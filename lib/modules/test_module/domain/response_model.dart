class ResponseModel {
  final int id;
  final String response;
  bool isSelected = false;

  ResponseModel({
    required this.id,
    required this.response,
    this.isSelected = false,
  });

  ResponseModel copyWith({
    int? id,
    String? response,
    bool? isSelected,
  }) {
    return ResponseModel(
      id: id ?? this.id,
      response: response ?? this.response,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      id: json['idRespuesta'],
      response: json['textoRespuesta'],
    );
  }
}
