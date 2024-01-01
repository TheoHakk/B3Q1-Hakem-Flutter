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
        final Machine machine = await api.fetchMachine(event.id);
        emit(MachineLoadedState(machine));
      } catch (e) {
        emit(MachineErrorState(e.toString()));
      }
    });

    on<CreateMachineEvent>((event, emit) async {
      try {
        await api.createMachine(
            event.productionGoal, event.sendingTime, event.name);
      } catch (e) {
        throw Exception('Failed to create machine');
      }
    });

    on<UpdateMachineEvent>((event, emit) async {
      try {
        await api.updateMachine(
            event.id, event.productionGoal, event.sendingTime, event.name);
      } catch (e) {
        throw Exception('Failed to update machine');
      }
    });

    on<DeleteMachineEvent>((event, emit) async {
      try {
        await api.deleteMachine(event.id);
      } catch (e) {
        throw Exception('Failed to delete machine');
      }
    });
  }
}
