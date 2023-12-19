import 'package:b3q1_hakem_projet_flutter/Model/API/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/Machine/machine.dart';
import 'machines_event.dart';
import 'machines_state.dart';

class MachinesBloc extends Bloc<MachinesEvent, MachinesState> {
  final Api api = Api();

  MachinesBloc() : super(MachinesInitialState()) {
    on<FetchMachinesEvent>((event, emit) async {
      emit(MachinesLoadingState());
      try {
        final List<Machine> machines =
            (await api.fetchAllMachines()).cast<Machine>();
        emit(MachinesLoadedState(machines));
      } catch (e) {
        print(e);
        emit(MachinesErrorState(e.toString()));
      }
    });

    on<LoadMachinesEvent>((event, emit) async {
      emit(MachinesLoadingState());
      try {
        final List<Machine> machines =
        (await api.fetchAllMachines()).cast<Machine>();
        emit(MachinesLoadedState(machines));
      } catch (e) {
        print(e);
        emit(MachinesErrorState(e.toString()));
      }
    });
  }
}
