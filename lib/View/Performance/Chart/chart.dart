import 'dart:async';

import 'package:b3q1_hakem_projet_flutter/BloC/Units/units_bloc.dart';
import 'package:b3q1_hakem_projet_flutter/BloC/Units/units_event.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../BloC/Units/units_state.dart';
import '../../../Model/Machine/machine.dart';
import '../../../Model/Unit/unit.dart';

class Chart extends StatefulWidget {
  final Color dark = Colors.redAccent;
  final Color light = Colors.greenAccent;

  final Machine machine;

  const Chart({super.key, required this.machine});

  @override
  State<StatefulWidget> createState() => ChartState();
}

class ChartState extends State<Chart> {
  Timer? _timer;
  late int duration;
  late double goal;
  late List<Unit> units;
  late UnitsBloc _unitsBloc;

  @override
  void initState() {
    super.initState();

    duration = ((widget.machine.sendingTime) / 1000) as int;
    goal = (duration / 60) * widget.machine.productionGoal;

    _unitsBloc = BlocProvider.of<UnitsBloc>(context);
    _unitsBloc.add(FetchLastUnitsEvent((widget.machine.id).toString()));
    _timer = Timer.periodic(Duration(seconds: duration), (timer) {
      _unitsBloc.add(FetchLastUnitsEvent((widget.machine.id).toString()));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitsBloc, UnitsState>(
        bloc: _unitsBloc,
        builder: (context, state) {
          if (state is UnitsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UnitsLoadedState) {
            units = state.units;
            return buildChart();
          } else if (state is UnitsErrorState) {
            return const Text('Une erreur est survenue');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget buildChart() {
    return AspectRatio(
      aspectRatio: 2.5,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: LayoutBuilder(builder: (context, constraints) {
          final barsSpace = 4.0 * constraints.maxWidth / 40;
          final barsWidth = 8.0 * constraints.maxWidth / 200;
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.center,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) => bottomTitles(value),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) => leftTitles(value),
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  groupsSpace: barsSpace,
                  barGroups: getData(barsWidth, barsSpace),
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: goal,
                        color: Colors.blueAccent,
                        strokeWidth: 2,
                        dashArray: [10, 5],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget bottomTitles(double value) {
    const style = TextStyle(fontSize: 10);
    String text;
    if (value.toInt() < units.length) {
      text =
          '${units[value.toInt()].hour}:${units[value.toInt()].minute}:${units[value.toInt()].second}\n with : ${units[value.toInt()].nbUnits}';
    } else {
      text = '';
    }
    return Text(text, style: style);
  }

  Widget leftTitles(double value) {
    const style = TextStyle(fontSize: 10);
    return Text(value.toString(), style: style);
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    return List.generate(units.length, (i) {
      double unitValue = units[i].nbUnits.toDouble();
      return BarChartGroupData(
        x: i,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: unitValue,
            rodStackItems: [
              BarChartRodStackItem(
                  0, unitValue, unitValue >= goal ? widget.light : widget.dark),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      );
    });
  }
}
