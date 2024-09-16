import 'package:equatable/equatable.dart';

import '../../../../helpers/paths.dart';

enum TestStatus { initial, loading, loaded, error }

class TestState extends Equatable {
  final List<TestModel> testList;
  final List<CompletedTestModel> completedTestList;
  final List<HistoryTestModel> historyTestList;
  final TestStatus status;
  const TestState({
    this.testList = const [],
    this.completedTestList = const [],
    this.status = TestStatus.initial,
    this.historyTestList = const [],
  });

  TestState copyWith({
    List<TestModel>? testList,
    List<CompletedTestModel>? completedTestList,
    TestStatus? status,
    List<HistoryTestModel>? historyTestList,
  }) {
    return TestState(
      testList: testList ?? this.testList,
      completedTestList: completedTestList ?? this.completedTestList,
      status: status ?? this.status,
      historyTestList: historyTestList ?? this.historyTestList,
    );
  }

  @override
  List<Object> get props =>
      [testList, completedTestList, status, historyTestList];
}
