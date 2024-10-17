class ResponseModel {
  final int id;
  final String response;
  final int value;
  bool isSelected = false;

  ResponseModel({
    required this.id,
    required this.response,
    this.value = 0,
    this.isSelected = false,
  });

  ResponseModel copyWith({
    int? id,
    String? response,
    int? value,
    bool? isSelected,
  }) {
    return ResponseModel(
      id: id ?? this.id,
      response: response ?? this.response,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      id: json['answerId'],
      response: json['answerText'],
      value: json['value'],
    );
  }
}
