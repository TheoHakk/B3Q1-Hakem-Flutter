import '../../Model/API/api.dart';
import '../../Model/Machine/machine.dart';
import 'machine_event.dart';
import 'package:bloc/bloc.dart';
import 'machine_state.dart';

class MachineBloc extends Bloc<MachineEvent, MachineState> {
  final Api api = Api();

  MachineBloc() : super(MachineInitialState()) {
    on<FetchMachineEvent>((event, emit) async {
      emit(MachineLoadingState());
      try {
        print('machine bloc');
        print(event.id);
        final Machine machine = await api.fetchMachine(event.id);
        emit(MachineLoadedState(machine));
      } catch (e) {
        emit(MachineErrorState(e.toString()));
      }
    });

    on<LoadMachineEvent>((event, emit) async {
      emit(MachineLoadingState());
      try {
        print('machine bloc load');
        print(event.id);
        final Machine machine = await api.fetchMachine(event.id);
        emit(MachineLoadedState(machine));
      } catch (e) {
        emit(MachineErrorState(e.toString()));
      }
    });
  }
}
