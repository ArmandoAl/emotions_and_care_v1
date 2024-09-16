import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../helpers/paths.dart';

class PattientsCubit extends Cubit<PattientsState> {
  final SpecialistRepository _repository;

  PattientsCubit({required SpecialistRepository repository})
      : _repository = repository,
        super(const PattientsState());

  Future<void> getPattients(int idUser) async {
    emit(state.copyWith(status: PattientsStatus.loading));
    try {
      final patients = await _repository.getPatients(idUser);
      emit(state.copyWith(status: PattientsStatus.loaded, patients: patients));
    } catch (e) {
      emit(state.copyWith(status: PattientsStatus.error));
    }
  }
}
