import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../helpers/paths.dart';

class TestCubit extends Cubit<TestState> {
  final TestRepository repository;
  TestCubit({required this.repository}) : super(const TestState());

  //complete test
  Future<GoalWithTestInfoModel> onCompleteTest(
      int patientId, int testId, bool isFirtsTime) async {
    // Get the test to complete
    // Create a new list of completed tests with the completed test
    //get the testHistory

    final test = state.testList.firstWhere((element) => element.id == testId);

    //en el futuro este metodo retornara una clase que incluya el testInfoModel y el goal
    GoalWithTestInfoModel result = await repository.completeTest(patientId,
        testId, test.questions, state.completedTestList.isEmpty ? true : false);

    final List<CompletedTestModel> updatedCompletedTestList;

    if (state.completedTestList.isEmpty) {
      updatedCompletedTestList = [
        ...state.completedTestList,
        CompletedTestModel(
          userId: patientId,
          testId: testId,
          date: DateTime.now(),
        ),
      ];
    } else {
      updatedCompletedTestList = state.completedTestList
          .map((e) => e.testId == testId
              ? e.copyWith(
                  date: DateTime.now(),
                )
              : e)
          .toList();
    }

    final List<HistoryTestModel> updatedHistoryList;

    if (state.historyTestList.isEmpty) {
      updatedHistoryList = [
        ...state.historyTestList,
        HistoryTestModel(
          id: 1,
          name: test.name,
          idCuestionario: testId,
          testInfoList: [result.testInfoModel],
        ),
      ];
    } else {
      updatedHistoryList = state.historyTestList
          .map((e) => e.idCuestionario == testId
              ? e.copyWith(
                  testInfoList: [result.testInfoModel, ...e.testInfoList],
                )
              : e)
          .toList();
    }

    clearTest(test);

    // Emit a new state with the updated list of completed tests
    emit(state.copyWith(
      completedTestList: updatedCompletedTestList,
      historyTestList: updatedHistoryList,
    ));

    return result;
  }

  void clearTest(TestModel test) {
    final updatedTestList = state.testList
        .map((e) => e.id == test.id
            ? e.copyWith(
                questions: e.questions
                    .map((q) => q.copyWith(
                        answers: q.answers
                            .map((a) => a.copyWith(isSelected: false))
                            .toList()))
                    .toList())
            : e)
        .toList();
    emit(state.copyWith(testList: updatedTestList));
  }

  Future<void> getTest(int userId) async {
    emit(state.copyWith(status: TestStatus.loading));
    try {
      final CompleteTestHistory testList = await repository.getTest(userId);
      emit(state.copyWith(
          testList: testList.testList,
          completedTestList: testList.completedTestList,
          historyTestList: testList.historyTestList,
          status: TestStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: TestStatus.error));
    }
  }

  //select question response
  void onSelectResponse(int testId, int questionId, int responseId) {
    // Create a new list of tests with the updated test
    final updatedTestList = state.testList
        .map((e) => e.id == testId
            ? e.copyWith(
                questions: e.questions
                    .map((q) => q.id == questionId
                        ? q.copyWith(
                            answers: q.answers
                                .map((a) => a.id == responseId
                                    ? a.copyWith(isSelected: true)
                                    : a.copyWith(isSelected: false))
                                .toList())
                        : q)
                    .toList())
            : e)
        .toList();
    // Emitir un nuevo estado con la lista de pruebas actualizada
    emit(state.copyWith(testList: updatedTestList));
  }
}
