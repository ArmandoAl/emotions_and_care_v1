import 'package:equatable/equatable.dart';

enum BegginStatus { start, login, register, loading, error }

class BegginState extends Equatable {
  final BegginStatus status;
  const BegginState({
    this.status = BegginStatus.start,
  });

  BegginState copyWith({
    BegginStatus? status,
  }) {
    return BegginState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [];
}
