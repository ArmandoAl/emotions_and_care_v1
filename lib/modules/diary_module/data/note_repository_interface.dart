import '../../../helpers/paths.dart';

abstract class INoteRepository {
  Future<GoalWithNote> addNote(NoteModel note, int patientId, bool isFirstTime);
  Future<bool> deleteNote(int idNote);
  Future<List<NoteModel>> getNotes(int patientId);
}
