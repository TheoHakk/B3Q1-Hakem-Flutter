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
  const Performance({super.key, required this.id});

  final String id;

  @override
  State<Performance> createState() => _Performance();
}

class _Performance extends State<Performance> {
  late UnitsBloc _unitsBloc;
  late MachineBloc _machineBloc;

  Timer? _timer;
  int duration = 10;

  @override
  void initState() {
    super.initState();
    _machineBloc = BlocProvider.of<MachineBloc>(context);
    _unitsBloc = BlocProvider.of<UnitsBloc>(context);
    _unitsBloc.add(FetchLastUnit(widget.id));
    _machineBloc.add(LoadMachineEvent(widget.id));
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: duration), (timer) {
      BlocProvider.of<MachineBloc>(context).add(LoadMachineEvent(widget.id));
      _unitsBloc = BlocProvider.of<UnitsBloc>(context);
      _unitsBloc.add(FetchLastUnit(widget.id));
    });
  }

  void _updateTimerDuration(int sendingTime) {
    int newDuration = (sendingTime / 1000).round();
    if (newDuration != duration) {
      duration = newDuration;
      _startTimer();
    }
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
            _updateTimerDuration(machine.sendingTime);
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
