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

  final BehaviorSubject<Unit> _unitsStreamController = BehaviorSubject<Unit>();
  final BehaviorSubject<Machine> _machineStreamController =
      BehaviorSubject<Machine>();

  @override
  void initState() {
    super.initState();

    _machineBloc = BlocProvider.of<MachineBloc>(context);
    _unitsBloc = BlocProvider.of<UnitsBloc>(context);

    void fetchData() {
      _unitsBloc.add(FetchLastUnit(widget.machineId));
      _machineBloc.add(LoadMachineEvent(widget.machineId));
    }

    if (widget.machineId != 'null') {
      fetchData();
      _timer = Timer.periodic(Duration(seconds: duration), (Timer t) {
        fetchData();
      });
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
  }

  @override
  Widget build(BuildContext context) {
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
                return _buildPerformanceView(unit, machine);
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _unitsStreamController.close();
    _machineStreamController.close();
    super.dispose();
  }

  Widget _buildPerformanceView(Unit unit, Machine machine) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: Column(
        children: [
          Text('Actual : ${unit.nbUnits} / ${machine.productionGoal}',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Expanded(flex: 2, child: _buildRadialTextPointer(unit, machine)),
        ],
      ),
    );
  }

  SfRadialGauge _buildRadialTextPointer(Unit unit, Machine machine) {
    double actualPointerValue = (unit.nbUnits / machine.productionGoal) * 60;

    return SfRadialGauge(
      axes: <RadialAxis>[
        _buildRadialAxis(actualPointerValue),
        _buildTextRadialAxis(),
      ],
    );
  }

  RadialAxis _buildRadialAxis(double actualPointerValue) {
    return RadialAxis(
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
        _buildGaugeRange(0, 40, 0xFFDD3800),
        _buildGaugeRange(40.5, 80, 0xFFFFDF10),
        _buildGaugeRange(80.5, 120, 0xFF64BE00),
      ],
    );
  }

  RadialAxis _buildTextRadialAxis() {
    return RadialAxis(
      showAxisLine: false,
      showLabels: false,
      showTicks: false,
      startAngle: 180,
      endAngle: 360,
      maximum: 120,
      radiusFactor: 0.85,
      canScaleToFit: true,
      pointers: <GaugePointer>[
        _buildMarkerPointer('Insuffisant', 20.5),
        _buildMarkerPointer('Dans la moyenne', 60.5),
        _buildMarkerPointer('Bon !!', 100.5),
      ],
    );
  }

  GaugeRange _buildGaugeRange(double startValue, double endValue, int color) {
    return GaugeRange(
      startValue: startValue,
      endValue: endValue,
      startWidth: 0.45,
      endWidth: 0.45,
      sizeUnit: GaugeSizeUnit.factor,
      color: Color(color),
    );
  }

  MarkerPointer _buildMarkerPointer(String text, double value) {
    return MarkerPointer(
      markerType: MarkerType.text,
      text: text,
      value: value,
      textStyle: const GaugeTextStyle(
          fontWeight: FontWeight.bold, fontFamily: 'Times'),
      offsetUnit: GaugeSizeUnit.factor,
      markerOffset: -0.12,
    );
  }
}
