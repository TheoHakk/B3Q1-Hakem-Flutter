import 'dart:async';

import 'package:b3q1_hakem_projet_flutter/BloC/Unit/last_unit_state.dart';
import 'package:b3q1_hakem_projet_flutter/BloC/Units/units_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../BloC/Unit/last_unit_bloc.dart';
import '../../../BloC/Unit/last_unit_event.dart';
import '../../../BloC/Units/units_event.dart';
import '../../../BloC/Units/units_state.dart';
import '../../../Model/Machine/machine.dart';
import '../../../Model/Unit/unit.dart';

class Performance extends StatefulWidget {
  const Performance({super.key, required this.machine});

  final Machine machine;

  @override
  State<Performance> createState() => _Performance();
}

class _Performance extends State<Performance> {
  late LastUnitBloc _lastUnitBloc;
  Timer? _timer;

  late int duration;
  late double goal;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    duration = ((widget.machine.sendingTime) / 1000) as int;
    goal = (duration / 60) * widget.machine.productionGoal;

    _lastUnitBloc = BlocProvider.of<LastUnitBloc>(context);
    _lastUnitBloc.add(FetchLastUnit((widget.machine.id).toString()));
    _timer = Timer.periodic(Duration(seconds: duration), (Timer t) {
      _lastUnitBloc.add(FetchLastUnit((widget.machine.id).toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastUnitBloc, LastUnitState>(
        bloc: _lastUnitBloc,
        builder: (context, state) {
          if (state is LastUnitInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LastUnitLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LastUnitLoadedState) {
            Unit unit = state.unit;
            return _buildPerformanceView(unit, goal);
          } else if (state is LastUnitErrorState) {
            return const Text(
                'Une erreur est survenue en récupérant les données');
          } else {
            return Text(state.toString());
          }
        });
  }

  Widget _buildPerformanceView(Unit unit, double goal) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: Column(
        children: [
          Expanded(flex: 2, child: _buildRadialTextPointer(unit, goal)),
        ],
      ),
    );
  }

  SfRadialGauge _buildRadialTextPointer(Unit unit, double goal) {
    double actualPointerValue = (unit.nbUnits / goal) * 60;

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
        canScaleToFit: true);
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
}
