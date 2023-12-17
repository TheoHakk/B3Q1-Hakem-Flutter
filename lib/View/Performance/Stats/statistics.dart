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
    return const Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Statistics", style: TextStyle(fontSize: 25)),
            Text("Machine name: Schaefer 1",
                style: TextStyle(fontSize: 20)),
            Text("Average daily production: 13.27 /minute",
                style: TextStyle(fontSize: 20)),
            Text("Average hour production: 15 /minute",
                style: TextStyle(fontSize: 20)),
            Text("Average minute production goal: 10",
                style: TextStyle(fontSize: 20)),
            Text("Start hour: 00:00", style: TextStyle(fontSize: 20)),
            Text("Time inactivity: actif",
                style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
