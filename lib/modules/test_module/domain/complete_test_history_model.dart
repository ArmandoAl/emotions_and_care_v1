import '../../../helpers/paths.dart';

class CompleteTestHistory {
  final List<HistoryTestModel> historyTestList;
  final List<CompletedTestModel> completedTestList;
  final List<TestModel> testList;

  CompleteTestHistory({
    required this.historyTestList,
    required this.completedTestList,
    required this.testList,
  });

  CompleteTestHistory copyWith({
    List<HistoryTestModel>? historyTestList,
    List<CompletedTestModel>? completedTestList,
    List<TestModel>? testList,
  }) {
    return CompleteTestHistory(
      historyTestList: historyTestList ?? this.historyTestList,
      completedTestList: completedTestList ?? this.completedTestList,
      testList: testList ?? this.testList,
    );
  }

  factory CompleteTestHistory.fromJson(Map<String, dynamic> json) {
    return CompleteTestHistory(
      historyTestList: List<HistoryTestModel>.from(
          json['historialCuestionarios']
              .map((x) => HistoryTestModel.fromJson(x))),
      completedTestList: List<CompletedTestModel>.from(
          json['cuestionarioCompletados']
              .map((x) => CompletedTestModel.fromJson(x))),
      testList: List<TestModel>.from(
          json['cuestionarios'].map((x) => TestModel.fromJson(x))),
    );
  }
}
