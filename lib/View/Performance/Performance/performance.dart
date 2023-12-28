import 'dart:async';

import 'package:b3q1_hakem_projet_flutter/BloC/Units/units_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../BloC/Machine/machine_bloc.dart';
import '../../../BloC/Machine/machine_event.dart';
import '../../../BloC/Machine/machine_state.dart';
import '../../../BloC/Units/units_event.dart';
import '../../../BloC/Units/units_state.dart';
import '../../../Model/Machine/machine.dart';
import '../../../Model/Unit/unit.dart';

class Performance extends StatefulWidget {
  const Performance({super.key, required this.machineId});

  final String machineId;

  @override
  State<Performance> createState() => _Performance();
}

class _Performance extends State<Performance> {
  late UnitsBloc _unitsBloc;
  late MachineBloc _machineBloc;

  Timer? _timer;
  int duration = 10;

  final StreamController<Unit> _unitsStreamController = StreamController.broadcast();
  final StreamController<Machine> _machineStreamController = StreamController.broadcast();


  @override
  void initState() {
    super.initState();

    _machineBloc = BlocProvider.of<MachineBloc>(context);
    _unitsBloc = BlocProvider.of<UnitsBloc>(context);
    _unitsBloc.add(FetchLastUnit(widget.machineId));
    _machineBloc.add(LoadMachineEvent(widget.machineId));

    _unitsBloc.stream.listen((state) {
      if (state is LastUnitLoadedState) {
        _unitsStreamController.add(state.unit);
      }
    });

    _machineBloc.stream.listen((state) {
      if (state is MachineLoadedState) {
        _machineStreamController.add(state.machine);
      }
    });

    _timer = Timer.periodic(Duration(seconds: duration), (timer) {
      _unitsBloc.add(FetchLastUnitsEvent(widget.machineId));
      _machineBloc.add(LoadMachineEvent(widget.machineId));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    return BlocBuilder<MachineBloc, MachineState>(
        bloc: _machineBloc,
        builder: (context, machineState) {
          if (machineState is MachineLoadingState) {
            return const CircularProgressIndicator();
          } else if (machineState is MachineLoadedState) {
            Machine machine = machineState.machine;
            return BlocBuilder<UnitsBloc, UnitsState>(
                bloc: _unitsBloc,
                builder: (context, state) {
                  if (state is LastUnitLoadingState) {
                    print("loading");
                    return const CircularProgressIndicator();
                  } else if (state is LastUnitLoadedState) {
                    Unit lastUnit = state.unit;
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: _buildRadialTextPointer(lastUnit, machine),
                          ),
                        ],
                      ),
                    );
                  } else if (state is LastUnitErrorState) {
                    return const Text('Une erreur est survenue');
                  } else {
                    return const Text('Une erreur est survenue et non gérée');
                  }
                });
          }
          return const Text('Une erreur est survenue');
        });
  }

  SfRadialGauge _buildRadialTextPointer(Unit unit, Machine machine) {
    double objectif = machine.productionGoal as double;
    double actual = unit.nbUnits as double;

    double actualPointerValue = (actual / objectif) * 60;

    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            showAxisLine: false,
            showLabels: false,
            showTicks: false,
            startAngle: 180,
            endAngle: 360,
            maximum: 120,
            canScaleToFit: true,
            radiusFactor: 0.79,
            pointers: <GaugePointer>[
              NeedlePointer(
                  needleEndWidth: 5,
                  needleLength: 0.7,
                  value: actualPointerValue,
                  knobStyle: const KnobStyle(knobRadius: 0)),
            ],
            ranges: <GaugeRange>[
              //ça va de 0 à 120
              GaugeRange(
                  startValue: 0,
                  endValue: 40,
                  startWidth: 0.45,
                  endWidth: 0.45,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: const Color(0xFFDD3800)),
              GaugeRange(
                  startValue: 40.5,
                  endValue: 80,
                  startWidth: 0.45,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.45,
                  color: const Color(0xFFFFDF10)),
              GaugeRange(
                  startValue: 80.5,
                  endValue: 120,
                  startWidth: 0.45,
                  endWidth: 0.45,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: const Color(0xFF64BE00)),
            ]),
        RadialAxis(
          showAxisLine: false,
          showLabels: false,
          showTicks: false,
          startAngle: 180,
          endAngle: 360,
          maximum: 120,
          radiusFactor: 0.85,
          canScaleToFit: true,
          pointers: const <GaugePointer>[
            MarkerPointer(
                markerType: MarkerType.text,
                text: 'Insuffisant',
                value: 20.5,
                textStyle: GaugeTextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Times'),
                offsetUnit: GaugeSizeUnit.factor,
                markerOffset: -0.12),
            MarkerPointer(
                markerType: MarkerType.text,
                text: 'Dans la moyenne',
                value: 60.5,
                textStyle: GaugeTextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Times'),
                offsetUnit: GaugeSizeUnit.factor,
                markerOffset: -0.12),
            MarkerPointer(
                markerType: MarkerType.text,
                text: 'Bon !!',
                value: 100.5,
                textStyle: GaugeTextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Times'),
                offsetUnit: GaugeSizeUnit.factor,
                markerOffset: -0.12)
          ],
        ),
      ],
    );
  }
}
