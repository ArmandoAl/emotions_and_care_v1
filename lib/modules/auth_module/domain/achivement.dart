class AchivementCollection {
  int? achievementCollectionId;
  List<UserAchievement>? userAchievements;

  AchivementCollection({
    this.achievementCollectionId,
    this.userAchievements,
  });

  AchivementCollection copyWith({
    int? achievementCollectionId,
    List<UserAchievement>? userAchievements,
  }) {
    return AchivementCollection(
      achievementCollectionId:
          achievementCollectionId ?? this.achievementCollectionId,
      userAchievements: userAchievements ?? this.userAchievements,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'achievementCollectionId': achievementCollectionId,
      'userAchievements': userAchievements?.map((x) => x.toJson()).toList(),
    };
  }

  factory AchivementCollection.fromJson(Map<String, dynamic> json) {
    return AchivementCollection(
      achievementCollectionId: json['achievementCollectionId'],
      userAchievements: json['userAchievements'] != null
          ? List<UserAchievement>.from(
              json['userAchievements'].map((x) => UserAchievement.fromJson(x)))
          : null,
    );
  }
}

class UserAchievement {
  int? userAchievementId;
  int? achievementId;
  Achievement? achievement;
  int? progress;
  DateTime? dateEarned;
  DateTime? dateCreated;
  DateTime? dateModified;

  UserAchievement({
    this.userAchievementId,
    this.achievementId,
    this.achievement,
    this.progress,
    this.dateEarned,
    this.dateCreated,
    this.dateModified,
  });

  UserAchievement copyWith({
    int? userAchievementId,
    int? achievementId,
    Achievement? achievement,
    int? progress,
    DateTime? dateEarned,
    DateTime? dateCreated,
    DateTime? dateModified,
  }) {
    return UserAchievement(
      userAchievementId: userAchievementId ?? this.userAchievementId,
      achievementId: achievementId ?? this.achievementId,
      achievement: achievement ?? this.achievement,
      progress: progress ?? this.progress,
      dateEarned: dateEarned ?? this.dateEarned,
      dateCreated: dateCreated ?? this.dateCreated,
      dateModified: dateModified ?? this.dateModified,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userAchievementId': userAchievementId,
      'achievementId': achievementId,
      'achievement': achievement?.toJson(),
      'progress': progress,
      'dateEarned': dateEarned?.toIso8601String(),
      'dateCreated': dateCreated?.toIso8601String(),
      'dateModified': dateModified?.toIso8601String(),
    };
  }

  factory UserAchievement.fromJson(Map<String, dynamic> json) {
    return UserAchievement(
      userAchievementId: json['userAchievementId'],
      achievementId: json['achievementId'],
      achievement: json['achievement'] != null
          ? Achievement.fromJson(json['achievement'])
          : null,
      progress: json['progress'],
      dateEarned: (DateTime.tryParse(json['dateEarned'] ?? '')),
      dateCreated: DateTime.tryParse(json['dateCreated'] ?? '')?.toLocal(),
      dateModified: DateTime.tryParse(json['dateModified'] ?? '')?.toLocal(),
    );
  }
}

class Achievement {
  int? achievementId;
  String? name;
  String? description;
  int? category;
  String? imageUrl;
  String? progressMap;
  DateTime? dateCreated;
  DateTime? dateModified;

  Achievement({
    this.achievementId,
    this.name,
    this.description,
    this.category,
    this.imageUrl,
    this.progressMap,
    this.dateCreated,
    this.dateModified,
  });

  Achievement copyWith({
    int? achievementId,
    String? name,
    String? description,
    int? category,
    String? imageUrl,
    String? progressMap,
    DateTime? dateCreated,
    DateTime? dateModified,
  }) {
    return Achievement(
      achievementId: achievementId ?? this.achievementId,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      progressMap: progressMap ?? this.progressMap,
      dateCreated: dateCreated ?? this.dateCreated,
      dateModified: dateModified ?? this.dateModified,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'achievementId': achievementId,
      'name': name,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'progressMap': progressMap,
      'dateCreated': dateCreated?.toIso8601String(),
      'dateModified': dateModified?.toIso8601String(),
    };
  }

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      achievementId: json['achievementId'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      imageUrl: json['imageUrl'],
      progressMap: json['progressMap'],
      dateCreated: DateTime.tryParse(json['dateCreated'] ?? '')?.toLocal(),
      dateModified: DateTime.tryParse(json['dateModified'] ?? '')?.toLocal(),
    );
  }
}
