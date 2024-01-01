import 'package:equatable/equatable.dart';
import '../../Model/Unit/unit.dart';

abstract class LastUnitState extends Equatable {
  const LastUnitState();

  @override
  List<Object> get props => [];
}

class LastUnitInitialState extends LastUnitState {}

class LastUnitLoadingState extends LastUnitState {}

class LastUnitLoadedState extends LastUnitState {
  final Unit unit;

  LastUnitLoadedState(this.unit);
}

class LastUnitErrorState extends LastUnitState {
  final String message;

  LastUnitErrorState(this.message);
}
