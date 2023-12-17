import 'package:equatable/equatable.dart';
import '../../Model/Machine/machine.dart';

abstract class MachineState extends Equatable {
  const MachineState();

  @override
  List<Object> get props => [];
}

class MachineInitialState extends MachineState {}

class MachineLoadingState extends MachineState {}

class MachineLoadedState extends MachineState {
  final Machine machine;
  const MachineLoadedState(this.machine);

  @override
  List<Object> get props => [machine];
}

class MachineErrorState extends MachineState {}
