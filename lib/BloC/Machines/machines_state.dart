import 'package:equatable/equatable.dart';
import '../../Model/Machine/machine.dart';

abstract class MachinesState extends Equatable {
  const MachinesState();

  @override
  List<Object> get props => [];
}

class MachinesInitialState extends MachinesState {}

class MachinesLoadingState extends MachinesState {}

class MachinesLoadedState extends MachinesState {
  final List<Machine> machines;

  const MachinesLoadedState(this.machines);

  @override
  List<Object> get props => [machines];
}

class MachinesErrorState extends MachinesState {}