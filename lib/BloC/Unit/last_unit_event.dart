

import '../../Model/Unit/unit.dart';

abstract class LastUnitEvent {}

class FetchLastUnit extends LastUnitEvent {
  final String machineId;

  FetchLastUnit(this.machineId);
}

class LastUnitLoaded extends LastUnitEvent {
  final Unit unit;

  LastUnitLoaded(this.unit);
}
