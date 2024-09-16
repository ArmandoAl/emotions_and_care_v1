import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helpers/paths.dart';

class HomeCubit extends Cubit<HomeState> {
  final NotificationRepository repository;

  HomeCubit({required this.repository}) : super(const HomeState());

  Future<void> getNotification(int idPatient) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final notifications = await repository.getNotification(idPatient);
      emit(state.copyWith(
        items: [...state.items, notifications],
        status: HomeStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error));
    }
  }

  Future<void> deleteNotification(int id) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final notifications = await repository.deleteNotification(id);

      if (notifications) {
        emit(state.copyWith(
          items: state.items.where((element) => element.id != id).toList(),
          status: HomeStatus.loaded,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error));
    }
  }

  Future<void> getNotifications(int id) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      List<NotificationModel> notifications = await repository.init(id);

      emit(state.copyWith(
        items: notifications,
        status: HomeStatus.loaded,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: HomeStatus.error));
    }
  }

  // Future<void> onGetSticker() async {
  //   emit(state.copyWith(status: HomeStatus.loading));
  //   try {
  //     final goal = GoalModel(
  //         id: 1,
  //         title: "Gatito",
  //         type: GoalType.test,
  //         description: "Gatito",
  //         giftUrl: Assets.cat);

  //     emit(state
  //         .copyWith(goals: [...state.goals, goal], status: HomeStatus.loaded));
  //   } catch (e) {
  //     emit(state.copyWith(status: HomeStatus.error));
  //   }
  // }
}
