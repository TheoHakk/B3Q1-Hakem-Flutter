import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:b3q1_hakem_projet_flutter/BloC/Units/units_bloc.dart';
import 'package:b3q1_hakem_projet_flutter/BloC/Units/units_event.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../BloC/Machine/machine_bloc.dart';
import '../../../BloC/Machine/machine_event.dart';
import '../../../BloC/Machine/machine_state.dart';
import '../../../BloC/Units/units_state.dart';
import '../../../Model/Machine/machine.dart';
import '../../../Model/Unit/unit.dart';

class Chart extends StatefulWidget {
  final String machineId;
  final Color dark = Colors.redAccent;
  final Color light = Colors.greenAccent;

  const Chart({super.key, required this.machineId});

  @override
  State<StatefulWidget> createState() => ChartState();
}

class ChartState extends State<Chart> {
  Timer? _timer;
  double objectif = 5 as double;
  int duration = 10;
  late List<Unit> units;
  late UnitsBloc _unitsBloc;
  late MachineBloc _machineBloc;

  final BehaviorSubject<List<Unit>> _unitsStreamController = BehaviorSubject<
      List<Unit>>();

  @override
  void initState() {
    super.initState();

    _unitsBloc = BlocProvider.of<UnitsBloc>(context);
    _machineBloc = BlocProvider.of<MachineBloc>(context);
    _unitsBloc.add(FetchLastUnitsEvent(widget.machineId));
    _machineBloc.add(LoadMachineEvent(widget.machineId));


    void fetchData(){
      _unitsBloc.add(FetchLastUnitsEvent(widget.machineId));
      _machineBloc.add(LoadMachineEvent(widget.machineId));
    }

    fetchData();
    _timer = Timer.periodic(Duration(seconds: duration), (timer) {
      fetchData();
    });

    _unitsBloc.stream.listen((state) {
      if (state is UnitsLoadedState) {
        _unitsStreamController.add(state.units);
      }
    });

    _machineBloc.stream.listen((state) {
      if (state is MachineLoadedState) {
        setState(() {
          objectif = ((state.machine.productionGoal)/(60000/state.machine.sendingTime));
          print(objectif);
        });
      }
    });

  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Unit>>(
      stream: _unitsStreamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          units = snapshot.data!;
          return buildChart();
        } else if (snapshot.hasError) {
          return const CircularProgressIndicator();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
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
                    topTitles: const AxisTitles(sideTitles: SideTitles(
                        showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(
                        showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  groupsSpace: barsSpace,
                  barGroups: getData(barsWidth, barsSpace),
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: objectif.toDouble(),
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
      '${units[value.toInt()].hour}:${units[value.toInt()].minute}:${units[value
          .toInt()].second}\n with : ${units[value.toInt()].nbUnits}';
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
      return BarChartGroupData(
        x: i,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: units[i].nbUnits.toDouble(),
            rodStackItems: [
              BarChartRodStackItem(0, objectif.toDouble(), widget.dark),
              BarChartRodStackItem(objectif.toDouble(), 50000.0, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      );
    });
  }
}