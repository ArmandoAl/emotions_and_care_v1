import '../../../../helpers/paths.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final ScheduleRepository repository;
  ScheduleCubit({required this.repository}) : super(const ScheduleState());
  //Add date to the list
  Future<GoalwithDate> addDate(
      int idPatient, DateModel date, int idSpecialist) async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    try {
      final GoalwithDate res =
          await repository.addSchedule(idPatient, date, idSpecialist);

      date = date.copyWith(id: res.id);

      emit(state.copyWith(
        dates: [...state.dates, date],
        status: ScheduleStatus.loaded,
      ));

      return res;
    } catch (e) {
      emit(state.copyWith(status: ScheduleStatus.error));
      throw Exception('Failed to add date');
    }
  }

  Future<bool> updateDate(DateModel date, int patientId, int specialistId,
      bool isFromSpecialist) async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    try {
      await repository.updateSchedule(
          date, patientId, specialistId, isFromSpecialist);
      final List<DateModel> dates = state.dates;
      final int index = dates.indexWhere((element) => element.id == date.id);
      dates[index] = date;
      emit(state.copyWith(
        dates: dates,
        status: ScheduleStatus.loaded,
      ));
      return true;
    } catch (e) {
      emit(state.copyWith(status: ScheduleStatus.error));
      return false;
    }
  }

  Future<bool> updateDateStatus(DateModel date) async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    try {
      await repository.updateStatusCita(date);
      final List<DateModel> dates = state.dates;
      final int index = dates.indexWhere((element) => element.id == date.id);
      dates[index] = date;
      emit(state.copyWith(
        dates: dates,
        status: ScheduleStatus.loaded,
      ));
      return true;
    } catch (e) {
      emit(state.copyWith(status: ScheduleStatus.error));
      return false;
    }
  }

  //delete date from the list
  Future<void> deleteDate(int idDate) async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    try {
      await repository.deleteSchedule(idDate);
      final List<DateModel> dates = state.dates;
      dates.removeWhere((element) => element.id == idDate);
      emit(state.copyWith(
        dates: dates,
        status: ScheduleStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: ScheduleStatus.error));
    }
  }

  //Confirm date by patient
  Future<void> confirmDateByPatient(DateModel date, int idPatient) async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    try {
      await repository.confirmDateByPatient(date.id!, idPatient);
      final List<DateModel> dates = state.dates;
      final int index = dates.indexWhere((element) => element.id == date.id);
      dates[index] = date;
      emit(state.copyWith(
        dates: dates,
        status: ScheduleStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: ScheduleStatus.error));
    }
  }

  //Confirm date by espetialist
  Future<void> confirmDateByEspetialist(
      int idDate, int idEspetialist, int idPatient) async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    try {
      await repository.cancelDateBySpecialist(idDate, idEspetialist, idPatient);
      final List<DateModel> dates = state.dates;
      final int index = dates.indexWhere((element) => element.id == idDate);
      dates[index] = dates[index].copyWith(confirmByEspetialist: true);
      emit(state.copyWith(
        dates: dates,
        status: ScheduleStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: ScheduleStatus.error));
    }
  }

  //cancel date by patient
  Future<void> cancelDateByPatient(int idDate, int idPatient) async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    try {
      await repository.cancelDateByPatient(idDate, idPatient);
      final List<DateModel> dates = state.dates;
      final int index = dates.indexWhere((element) => element.id == idDate);
      dates[index] = dates[index].copyWith(confirmByPatient: false);
      emit(state.copyWith(
        dates: dates,
        status: ScheduleStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: ScheduleStatus.error));
    }
  }

  //cancel date by espetialist
  Future<void> cancelDateByEspetialist(
      int idDate, int idEspetialist, int idPatient) async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    try {
      await repository.cancelDateBySpecialist(idDate, idEspetialist, idPatient);
      final List<DateModel> dates = state.dates;
      final int index = dates.indexWhere((element) => element.id == idDate);
      dates[index] = dates[index].copyWith(confirmByEspetialist: false);
      emit(state.copyWith(
        dates: dates,
        status: ScheduleStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: ScheduleStatus.error));
    }
  }

  Future<void> getSchedule(int patientId, {bool reloading = false}) async {
    emit(state.copyWith(
        status: reloading ? ScheduleStatus.reloading : ScheduleStatus.loading));
    try {
      final List<DateModel> dates = await repository.getSchedules(patientId);
      emit(state.copyWith(
        dates: dates,
        status: ScheduleStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: ScheduleStatus.error));
    }
  }

  Future<void> getDatesForSpecialist(int id, {bool reloading = false}) async {
    emit(state.copyWith(
        status: reloading ? ScheduleStatus.reloading : ScheduleStatus.loading));
    try {
      final List<DateModel> dates = await repository.getDatesForSpecialist(id);
      emit(state.copyWith(
        dates: dates,
        status: ScheduleStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: ScheduleStatus.error));
    }
  }

  Future<void> addDateBySpecialist(
      int idSpecialist, DateModel date, PatientModel patient) async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    try {
      final int resId =
          await repository.addDateBySpecialist(idSpecialist, date, patient.id!);
      date = date.copyWith(id: resId, patient: patient);
      emit(state.copyWith(
        dates: [...state.dates, date],
        status: ScheduleStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: ScheduleStatus.error));
    }
  }

  Future<void> getSpecialists() async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    try {
      final List<SpecialistModel> specialists =
          await repository.getSpecialists(state.offset);
      emit(state.copyWith(
        specialists: specialists,
        auxiliar: specialists,
        offset: 0,
        isTheTotal: false,
        status: ScheduleStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: ScheduleStatus.error));
    }
  }

  void searchSpecialisInTime(String value) {
    final List<SpecialistModel> specialists = state.auxiliar;
    final List<SpecialistModel> result = [];
    for (final SpecialistModel specialist in specialists) {
      if (specialist.name!.toLowerCase().contains(value.toLowerCase())) {
        result.add(specialist);
      }
    }
    emit(state.copyWith(specialists: result));
  }

  void clean() {
    emit(const ScheduleState());
  }
}
