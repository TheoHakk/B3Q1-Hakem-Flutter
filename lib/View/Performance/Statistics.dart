import 'package:flutter/material.dart';

import '../../Model/Machine.dart';

class Statistics extends StatefulWidget {
  final Machine machine;
  final String title;

  const Statistics({super.key, required this.title, required this.machine});

  @override
  State<Statistics> createState() => _Statistics(machine);
}

class _Statistics extends State<Statistics> {
  late Machine machine;

  _Statistics(this.machine);

  @override
  build(BuildContext context) {
    return (Column(children: [
      Column(textDirection: TextDirection.ltr, children: [
        const Text("Statistics", style: TextStyle(fontSize: 25)),
        Text("Machine name: ${machine.getName()}",
            style: const TextStyle(fontSize: 20)),
        Text(
            "Average daily production: ${machine.getAverageDailyProduction()} /minute",
            style: const TextStyle(fontSize: 20)),
        Text(
            "Average hour production: ${machine.getAverageHourProduction()} /minute",
            style: const TextStyle(fontSize: 20)),
        Text(
            "Average minute production goal: ${machine.getAverageMinuteProductionGoal()}",
            style: const TextStyle(fontSize: 20)),
        Text("Start hour: ${machine.getStartHour()}",
            style: const TextStyle(fontSize: 20)),
        Text("Time inactivity: since ${machine.getTimeInactivity()} minute(s)",
            style: const TextStyle(fontSize: 20)),
      ]),
    ]));
  }
}
