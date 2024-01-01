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

  int duration = 10;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
            return const CircularProgressIndicator();
          } else if (state is LastUnitLoadingState) {
            return const CircularProgressIndicator();
          } else if (state is LastUnitLoadedState) {
            Unit unit = state.unit;
            return _buildPerformanceView(unit, widget.machine);
          } else if (state is LastUnitErrorState) {
            return const Text(
                'Une erreur est survenue en récupérant les données');
          } else {
            return Text(state.toString());
          }
        });
  }

  Widget _buildPerformanceView(Unit unit, Machine machine) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: Column(
        children: [
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
