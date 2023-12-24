import '../../Model/Unit/unit.dart';

abstract class UnitsEvent {}



class FetchLastUnitsEvent extends UnitsEvent {
  final String machineId;

  FetchLastUnitsEvent(this.machineId);
}

class FetchLastUnit extends UnitsEvent {
  final String machineId;

  FetchLastUnit(this.machineId);
}



class LoadLastUnitsEvent extends UnitsEvent {
  final String machineId;

  LoadLastUnitsEvent(this.machineId);
}

class LoadLastUnit extends UnitsEvent {
  final String machineId;

  LoadLastUnit(this.machineId);
}



class LastUnitLoaded extends UnitsEvent {
  final Unit unit;

  LastUnitLoaded(this.unit);
}

class LastUnitsLoaded extends UnitsEvent {
  final List<Unit> units;

  LastUnitsLoaded(this.units);
}

