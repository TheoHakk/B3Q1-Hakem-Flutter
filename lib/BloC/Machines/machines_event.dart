import 'package:flutter/cupertino.dart';
import '../../Model/Machine/machine.dart';

@immutable
abstract class MachineEvent {}

class LoadMachines extends MachineEvent {}

class AddMachine extends MachineEvent {
  final Machine machine;

  AddMachine(this.machine);
}

class UpdateMachine extends MachineEvent {
  final Machine machine;

  UpdateMachine(this.machine);
}

class DeleteMachine extends MachineEvent {
  final String machineId;

  DeleteMachine(this.machineId);
}