import 'package:bloc/bloc.dart';
import 'machines_event.dart';
import 'machines_state.dart';



class MachineBloc extends Bloc<MachineEvent, MachineState> {
  final HttpService _httpService;

  MachineBloc(this._httpService) : super(MachineInitial());

  Stream<MachineState> mapEventToState(MachineEvent event) async* {
    try {
      yield MachineLoading();

      if (event is LoadMachines) {
        final machines = await _httpService.getMachines();
        yield MachineLoaded(machines);
      } else if (event is AddMachine) {
        await _httpService.addMachine(event.machine);
        yield MachineOperationSuccess('Machine added successfully.');
      } else if (event is UpdateMachine) {
        await _httpService.updateMachine(event.machine);
        yield MachineOperationSuccess('Machine updated successfully.');
      } else if (event is DeleteMachine) {
        await _httpService.deleteMachine(event.machineId);
        yield MachineOperationSuccess('Machine deleted successfully.');
      }
    } catch (e) {
      yield MachineError('Failed to perform operation: $e');
    }
  }
}
