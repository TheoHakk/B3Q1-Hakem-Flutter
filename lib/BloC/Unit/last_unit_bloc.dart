import 'package:bloc/bloc.dart';

import '../../Model/API/api.dart';
import '../../Model/Unit/unit.dart';
import 'last_unit_event.dart';
import 'last_unit_state.dart';

class LastUnitBloc extends Bloc<LastUnitEvent, LastUnitState> {
  final Api api = Api();

  LastUnitBloc() : super(LastUnitInitialState()) {
    on<FetchLastUnit>((event, emit) async {
      emit(LastUnitLoadingState());
      try {
        Unit unit = await api.fetchLastUnit(event.machineId);
        emit(LastUnitLoadedState(unit));
      } catch (e) {
        emit(LastUnitErrorState(e.toString()));
      }
    });

  }
}