import 'package:b3q1_hakem_projet_flutter/BloC/Units/units_event.dart';
import 'package:b3q1_hakem_projet_flutter/BloC/Units/units_state.dart';
import 'package:bloc/bloc.dart';

import '../../Model/API/api.dart';
import '../../Model/Unit/unit.dart';

class UnitsBloc extends Bloc<UnitsEvent, UnitsState> {
  final Api api = Api();

  UnitsBloc() : super(UnitsInitialState()) {
    on<FetchLastUnitsEvent>((event, emit) async {
      emit(UnitsLoadingState());
      try {
        final List<Unit> units = await api.fetchLastUnits(event.machineId);
        emit(UnitsLoadedState(units));
      } catch (e) {
        emit(UnitsErrorState(e.toString()));
      }
    });

    on<FetchLastUnit>((event, emit) async {
      emit(UnitsLoadingState());
      try {
        print("fetching last unit");
        Unit unit = await api.fetchLastUnit(event.machineId);
        print("last unit fetched");
        emit(LastUnitLoadedState(unit));
      } catch (e) {
        print(e.toString());
        emit(UnitsErrorState(e.toString()));
      }
    });

    on<LoadLastUnitsEvent>((event, emit) async {
      emit(UnitsLoadingState());
      try {
        final List<Unit> units = await api.fetchLastUnits(event.machineId);
        emit(UnitsLoadedState(units));
      } catch (e) {
        emit(UnitsErrorState(e.toString()));
      }
    });

    on<LoadLastUnit>((event, emit) async {
      emit(UnitsLoadingState());
      try {
        final Unit unit = await api.fetchLastUnit(event.machineId);
        emit(LastUnitLoadedState(unit));
      } catch (e) {
        emit(UnitsErrorState(e.toString()));
      }
    });
  }
}