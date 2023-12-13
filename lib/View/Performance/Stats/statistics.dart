import 'package:flutter/material.dart';

import '../../../Model/Machine/machine.dart';

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
    return (Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Statistics", style: TextStyle(fontSize: 25)),
          Text("Machine name: ${machine.name}",
              style: const TextStyle(fontSize: 20)),
          Text("Average daily production: JENAIPAS /minute",
              style: const TextStyle(fontSize: 20)),
          Text("Average hour production: JENAIPAS /minute",
              style: const TextStyle(fontSize: 20)),
          Text("Average minute production goal: JENAIPAS",
              style: const TextStyle(fontSize: 20)),
          Text("Start hour: JENAIPAS", style: const TextStyle(fontSize: 20)),
          Text("Time inactivity: since JENAIPAS minute(s)",
              style: const TextStyle(fontSize: 20)),
        ]));
  }
}
