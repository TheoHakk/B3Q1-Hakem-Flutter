import 'package:equatable/equatable.dart';
import '../../Model/Unit/unit.dart';

abstract class UnitsState extends Equatable {
  const UnitsState();

  @override
  List<Object> get props => [];
}

class UnitsInitialState extends UnitsState {}

class UnitsLoadingState extends UnitsState {}

class UnitsLoadedState extends UnitsState {
  final List<Unit> units;

  UnitsLoadedState(this.units);
}

class UnitsErrorState extends UnitsState {
  final String message;

  UnitsErrorState(this.message);
}

