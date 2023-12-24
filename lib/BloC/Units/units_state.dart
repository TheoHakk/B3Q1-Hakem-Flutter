import '../../Model/Unit/unit.dart';

abstract class UnitsState {}

class UnitsInitialState extends UnitsState {}

class LastUnitInitialState extends UnitsState {}



class UnitsLoadingState extends UnitsState {}

class LastUnitLoadingState extends UnitsState {}



class UnitsLoadedState extends UnitsState {
  final List<Unit> units;

  UnitsLoadedState(this.units);
}

class LastUnitLoadedState extends UnitsState {
  final Unit unit;

  LastUnitLoadedState(this.unit);
}


class UnitsErrorState extends UnitsState {
  final String message;

  UnitsErrorState(this.message);
}

class LastUnitErrorState extends UnitsState {
  final String message;

  LastUnitErrorState(this.message);
}
