import 'dart:async';
import 'package:rxdart/rxdart.dart';
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

  final BehaviorSubject<Unit> _unitsStreamController =
      BehaviorSubject<Unit>();
  final BehaviorSubject<Machine> _machineStreamController =
      BehaviorSubject<Machine>();

  @override
  void initState() {
    super.initState();

    _machineBloc = BlocProvider.of<MachineBloc>(context);
    _unitsBloc = BlocProvider.of<UnitsBloc>(context);

    if (widget.machineId != 'null') {
      _unitsBloc.add(FetchLastUnit(widget.machineId));
      _machineBloc.add(LoadMachineEvent(widget.machineId));
    }

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
      if (widget.machineId != 'null') {
        _unitsBloc.add(FetchLastUnitsEvent(widget.machineId));
        _machineBloc.add(LoadMachineEvent(widget.machineId));
      }
    });
  }

  @override
  build(BuildContext context) {
    return StreamBuilder<Machine>(
      stream: _machineStreamController.stream,
      builder: (context, machineSnapshot) {
        if (machineSnapshot.hasData) {
          Machine machine = machineSnapshot.data!;
          return StreamBuilder<Unit>(
            stream: _unitsStreamController.stream,
            builder: (context, unitSnapshot) {
              if (unitSnapshot.hasData) {
                Unit unit = unitSnapshot.data!;
                return ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height),
                  child: Column(
                    children: [
                      Text(
                        'Actual : ${unit.nbUnits} / ${machine.productionGoal}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        flex: 2,
                        child: _buildRadialTextPointer(unit, machine),
                      ),
                    ],
                  ),
                );
              } else if (unitSnapshot.hasError) {
                return const Text('Error while loading units');
              } else {
                return Text('Error not captured unit ${machine.name}');
              }
            },
          );
        } else if (machineSnapshot.hasError) {
          return const Text('Error while loading machine');
        } else {
          return const Text('Error not captured machine');
        }
      },
    );
  }

  @override
  void dispose() {
    _unitsStreamController.close();
    _machineStreamController.close();
    super.dispose();
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
