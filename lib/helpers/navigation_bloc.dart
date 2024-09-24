import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc(NavigationItem initialPage)
      : super(NavigationState(initialPage)) {
    on<NavigateTo>(
      (event, emit) {
        if (event.destination != state.selectedItem) {
          emit(NavigationState(event.destination));
        }
      },
    );
  }
}

sealed class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class NavigateTo extends NavigationEvent {
  final NavigationItem destination;

  const NavigateTo(this.destination);

  @override
  List<Object?> get props => [
        destination,
      ];
}

enum NavigationItem {
  home,
  test,
  dairy,
  community,
  schedule,
  settings,
}

class NavigationState extends Equatable {
  final NavigationItem selectedItem;

  const NavigationState(this.selectedItem);

  @override
  List<Object?> get props => [
        selectedItem,
      ];
}
