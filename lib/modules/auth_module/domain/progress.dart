class ProgressInfo {
  final String name;
  final int currentValue;
  final int targetValue;
  final String description;
  final bool isCompleted;

  ProgressInfo({
    required this.name,
    required this.currentValue,
    required this.targetValue,
    required this.description,
    required this.isCompleted,
  });

  factory ProgressInfo.fromJson(Map<String, dynamic> json) {
    return ProgressInfo(
      name: json['name'],
      currentValue: json['currentValue'],
      targetValue: json['targetValue'],
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'currentValue': currentValue,
      'targetValue': targetValue,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  ProgressInfo copyWith({
    String? name,
    int? currentValue,
    int? targetValue,
    String? description,
    bool? isCompleted,
  }) {
    return ProgressInfo(
      name: name ?? this.name,
      currentValue: currentValue ?? this.currentValue,
      targetValue: targetValue ?? this.targetValue,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class StageProgress {
  final int stageNumber;
  final List<ProgressInfo> progressInfos;

  StageProgress({
    required this.stageNumber,
    required this.progressInfos,
  });

  factory StageProgress.fromJson(Map<String, dynamic> json) {
    return StageProgress(
      stageNumber: json['stageNumber'],
      progressInfos: (json['progressInfos'] as List)
          .map((e) => ProgressInfo.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stageNumber': stageNumber,
      'progressInfos': progressInfos.map((e) => e.toJson()).toList(),
    };
  }

  StageProgress copyWith({
    int? stageNumber,
    List<ProgressInfo>? progressInfos,
  }) {
    return StageProgress(
      stageNumber: stageNumber ?? this.stageNumber,
      progressInfos: progressInfos ?? this.progressInfos,
    );
  }
}
