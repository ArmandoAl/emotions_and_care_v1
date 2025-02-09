import 'package:equatable/equatable.dart';

import '../../../../helpers/paths.dart';

enum HomeStatus { initial, loading, loaded, error, growing }

class HomeState extends Equatable {
  final List<NotificationModel> items;
  final List<GoalModel> goals;
  final HomeStatus status;

  const HomeState({
    this.items = const [],
    this.goals = const [],
    this.status = HomeStatus.initial,
  });

  HomeState copyWith({
    List<NotificationModel>? items,
    List<GoalModel>? goals,
    HomeStatus? status,
  }) {
    return HomeState(
      items: items ?? this.items,
      goals: goals ?? this.goals,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [items, status, goals];
}
