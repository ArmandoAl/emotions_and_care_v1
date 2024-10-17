class TestQuestionWithAnswer {
  final int id;
  final String question;
  final String answer;

  TestQuestionWithAnswer({
    required this.id,
    required this.question,
    required this.answer,
  });

  TestQuestionWithAnswer copyWith({
    int? id,
    String? question,
    String? answer,
  }) {
    return TestQuestionWithAnswer(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  factory TestQuestionWithAnswer.fromJson(Map<String, dynamic> json) {
    return TestQuestionWithAnswer(
      id: json['testQuestionWithAnswerId'],
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }
}
