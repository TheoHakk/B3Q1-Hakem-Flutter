import '../../Model/API/api.dart';
import 'machine_event.dart';
import 'package:bloc/bloc.dart';
import 'machine_state.dart';

class MachineBloc extends Bloc<MachineEvent, MachineState> {
  final Api api = Api();

  MachineBloc() : super(MachineInitialState()) {
    throw UnimplementedError();
  }
}
