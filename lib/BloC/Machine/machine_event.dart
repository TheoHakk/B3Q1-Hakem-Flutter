import 'package:equatable/equatable.dart';

abstract class MachineEvent extends Equatable {
  const MachineEvent();

  @override
  List<Object> get props => [];
}

class FetchMachineEvent extends MachineEvent {
  final String id;

  const FetchMachineEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CreateMachineEvent extends MachineEvent {
  final String productionGoal;
  final String sendingTime;
  final String name;

  const CreateMachineEvent(this.productionGoal, this.sendingTime, this.name);

  @override
  List<Object> get props => [productionGoal, sendingTime, name];
}

class UpdateMachineEvent extends MachineEvent {
  final String id;
  final String productionGoal;
  final String sendingTime;
  final String name;

  const UpdateMachineEvent(this.id, this.productionGoal, this.sendingTime, this.name);

  @override
  List<Object> get props => [id, productionGoal, sendingTime, name];
}