import 'package:equatable/equatable.dart';

abstract class MachinesEvent extends Equatable {
  const MachinesEvent();

  @override
  List<Object> get props => [];
}

class FetchMachinesEvent extends MachinesEvent {}