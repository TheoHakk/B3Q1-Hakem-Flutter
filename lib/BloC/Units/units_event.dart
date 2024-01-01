import '../../Model/Unit/unit.dart';

abstract class UnitsEvent {}

class FetchLastUnitsEvent extends UnitsEvent {
  final String machineId;

  FetchLastUnitsEvent(this.machineId);
}

class LastUnitsLoaded extends UnitsEvent {
  final List<Unit> units;

  LastUnitsLoaded(this.units);
}

