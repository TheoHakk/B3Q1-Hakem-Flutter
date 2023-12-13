import 'package:equatable/equatable.dart';

abstract class MachinesEvent extends Equatable {
  const MachinesEvent();

  @override
  List<Object> get props => [];
}

class FetchMachinesEvent extends MachinesEvent {}

class FetchAverageOfDayEvent extends MachinesEvent {
  final String machineId;

  const FetchAverageOfDayEvent(this.machineId);

  @override
  List<Object> get props => [machineId];
}

class FetchAverageOfHourEvent extends MachinesEvent {
  final String machineId;
  final String hour;

  const FetchAverageOfHourEvent(this.machineId, this.hour);

  @override
  List<Object> get props => [machineId, hour];
}

class FetchStartHourEvent extends MachinesEvent {
  final String machineId;

  const FetchStartHourEvent(this.machineId);

  @override
  List<Object> get props => [machineId];
}

class FetchLastHourProductionEvent extends MachinesEvent {}

class FetchLastUnitsEvent extends MachinesEvent {
  final String machineId;

  const FetchLastUnitsEvent(this.machineId);

  @override
  List<Object> get props => [machineId];
}

class FetchLastUnitEvent extends MachinesEvent {
  final String machineId;

  const FetchLastUnitEvent(this.machineId);

  @override
  List<Object> get props => [machineId];
}

class FetchAllUnitsEvent extends MachinesEvent {
  final String machineId;

  const FetchAllUnitsEvent(this.machineId);

  @override
  List<Object> get props => [machineId];
}

class FlushProductionDataEvent extends MachinesEvent {}

class FetchAllMachinesEvent extends MachinesEvent {}

class AddNewMachineEvent extends MachinesEvent {
  final String machineId;
  final String sendingTime;
  final String machineName;
  final String machineGoal;

  const AddNewMachineEvent(this.machineId, this.sendingTime, this.machineName, this.machineGoal);

  @override
  List<Object> get props => [machineId, sendingTime, machineName, machineGoal];
}
