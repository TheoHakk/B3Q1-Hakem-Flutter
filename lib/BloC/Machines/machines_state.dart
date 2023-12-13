import 'package:b3q1_hakem_projet_flutter/Model/Machine/machine.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class MachineState {}

class MachineInitial extends MachineState {}

class MachineLoading extends MachineState {}

class MachineLoaded extends MachineState {
  final List<Machine> machines;

  MachineLoaded(this.machines);
}

class MachineOperationSuccess extends MachineState {
  final String message;

  MachineOperationSuccess(this.message);
}

class MachineError extends MachineState {
  final String errorMessage;

  MachineError(this.errorMessage);
}