import '../../../helpers/paths.dart';

class HistoryTestModel {
  final int id;
  final int idCuestionario;
  final String name;
  final List<TestInfoModel> testInfoList;

  HistoryTestModel({
    required this.id,
    required this.idCuestionario,
    required this.name,
    required this.testInfoList,
  });

  HistoryTestModel copyWith({
    int? id,
    int? idCuestionario,
    String? name,
    List<TestInfoModel>? testInfoList,
  }) {
    return HistoryTestModel(
      id: id ?? this.id,
      idCuestionario: idCuestionario ?? this.idCuestionario,
      name: name ?? this.name,
      testInfoList: testInfoList ?? this.testInfoList,
    );
  }

  factory HistoryTestModel.fromJson(Map<String, dynamic> json) {
    return HistoryTestModel(
      id: json['questionnairesHistoryId'],
      idCuestionario: json['questionnaireId'],
      name: json['name'],
      testInfoList: List<TestInfoModel>.from(
          json['testInfoModels'].map((x) => TestInfoModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionnairesHistoryId': id,
      'name': name,
      'testInfoList': testInfoList.map((x) => x.toJson()).toList(),
    };
  }
}

class GoalWithTestInfoModel {
  final TestInfoModel testInfoModel;
  final GoalModel? goalModel;

  GoalWithTestInfoModel({
    required this.testInfoModel,
    this.goalModel,
  });

  GoalWithTestInfoModel copyWith({
    TestInfoModel? testInfoModel,
    GoalModel? goalModel,
  }) {
    return GoalWithTestInfoModel(
      testInfoModel: testInfoModel ?? this.testInfoModel,
      goalModel: goalModel ?? this.goalModel,
    );
  }

  factory GoalWithTestInfoModel.fromJson(Map<String, dynamic> json) {
    return GoalWithTestInfoModel(
      testInfoModel: TestInfoModel.fromJson(json['testInfoModel']),
      goalModel:
          json['logro'] != null ? GoalModel.fromJson(json['logro']) : null,
    );
  }
}
