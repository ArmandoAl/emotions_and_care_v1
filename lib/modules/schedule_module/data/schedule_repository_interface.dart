import '../../../helpers/paths.dart';

abstract class IScheduleRepository {
  Future<List<DateModel>> getSchedules(int isPatient);

  Future<GoalwithDate> addSchedule(int id, DateModel date, int idSpecialist);

  Future<bool> updateSchedule(
      DateModel date, int patientId, int specialistId, bool isFromSpecialist);
  Future<bool> deleteSchedule(int dateId);

  Future<bool> confirmDateByPatient(int idDate, int idPatient);

  Future<bool> confirmDateBySpecialist(
      int idDate, int idSpecialist, int idPatient);

  Future<bool> cancelDateByPatient(int idDate, int idPatient);

  Future<bool> cancelDateBySpecialist(
      int idDate, int idSpecialist, int idPatient);

  Future<List<DateRequestModel>> getDatesRequest(int idSpecialist);

  Future<List<DateModel>> getDatesForSpecialist(int idSpecialist);

  Future<List<SpecialistModel>> getSpecialists(int offset);

  Future<int> addDateBySpecialist(
      int idSpecialist, DateModel date, int idPatient);

  Future<bool> rejectDate(int idSpecialist, int idDate);

  Future<bool> aceptDateBySpecialist(int idSpecialist, int idDate);
}
