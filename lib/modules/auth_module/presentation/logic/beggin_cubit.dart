import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helpers/paths.dart';

class BegginCubit extends Cubit<BegginState> {
  BegginCubit() : super(const BegginState());

  // Future<void> beggin() async {
  //   emit(BegginLoading());
  //   final result = await _begginUseCase();
  //   result.fold(
  //     (failure) => emit(BegginError(failure)),
  //     (success) => emit(BegginSuccess(success)),
  //   );
  // }
}
