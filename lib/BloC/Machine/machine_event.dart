import 'package:equatable/equatable.dart';

abstract class MachineEvent extends Equatable {
  const MachineEvent();

  @override
  List<Object> get props => [];
}

class LoadMachineEvent extends MachineEvent {
  final String id;

  const LoadMachineEvent(this.id);

  @override
  List<Object> get props => [id];
}

class FetchMachineEvent extends MachineEvent {
  final String id;

  const FetchMachineEvent(this.id);

  @override
  List<Object> get props => [id];
}