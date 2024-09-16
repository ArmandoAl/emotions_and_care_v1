class TermAndConditions {
  final int id;
  final String terms;

  TermAndConditions({
    required this.id,
    required this.terms,
  });

  TermAndConditions copyWith({
    int? id,
    String? terms,
  }) {
    return TermAndConditions(
      id: id ?? this.id,
      terms: terms ?? this.terms,
    );
  }

  factory TermAndConditions.fromJson(Map<String, dynamic> json) {
    return TermAndConditions(
      id: json['idTerminosYCondiciones'],
      terms: json['terminosYCondiciones'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idTerminosYCondiciones': id,
      'terminosYCondiciones': terms,
    };
  }
}
