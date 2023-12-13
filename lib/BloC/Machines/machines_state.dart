import 'package:equatable/equatable.dart';
import '../../Model/Machine/machine.dart';

abstract class MachinesState extends Equatable {
  const MachinesState();

  @override
  List<Object> get props => [];
}

class MachinesInitialState extends MachinesState {}



class MachinesLoadedState extends MachinesState {
  final List<Machine> machines;

  const MachinesLoadedState(this.machines);

  @override
  List<Object> get props => [machines];
}

class MachinesErrorState extends MachinesState {}

class AverageOfDayLoadedState extends MachinesState {
  final double average;

  const AverageOfDayLoadedState(this.average);

  @override
  List<Object> get props => [average];
}

class AverageOfHourLoadedState extends MachinesState {
  final double average;

  const AverageOfHourLoadedState(this.average);

  @override
  List<Object> get props => [average];
}

class StartHourLoadedState extends MachinesState {
  final int startHour;
  final int startMinute;

  const StartHourLoadedState(this.startHour, this.startMinute);

  @override
  List<Object> get props => [startHour, startMinute];
}

class LastHourProductionLoadedState extends MachinesState {
  final int lastHour;
  final int lastMinute;

  const LastHourProductionLoadedState(this.lastHour, this.lastMinute);

  @override
  List<Object> get props => [lastHour, lastMinute];
}

class LastUnitsLoadedState extends MachinesState {
  final List<Map<String, dynamic>> lastUnits;

  const LastUnitsLoadedState(this.lastUnits);

  @override
  List<Object> get props => [lastUnits];
}

class LastUnitLoadedState extends MachinesState {
  final Map<String, dynamic> lastUnit;

  const LastUnitLoadedState(this.lastUnit);

  @override
  List<Object> get props => [lastUnit];
}

class AllUnitsLoadedState extends MachinesState {
  final List<Map<String, dynamic>> allUnits;

  const AllUnitsLoadedState(this.allUnits);

  @override
  List<Object> get props => [allUnits];
}

class AllMachinesLoadedState extends MachinesState {
  final List<Map<String, dynamic>> allMachines;

  const AllMachinesLoadedState(this.allMachines);

  @override
  List<Object> get props => [allMachines];
}

class NewMachineAddedState extends MachinesState {}

class FlushDataCompleteState extends MachinesState {}
