import '../../../helpers/paths.dart';

abstract class ITestRepository {
  Future<CompleteTestHistory> getTest(int pacienteId);

  Future<GoalWithTestInfoModel> completeTest(
    int idPaciente,
    int isTest,
    List<QuestionModel> answers,
    bool isFirtsTime,
  );
}
