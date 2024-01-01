import 'package:flutter/material.dart';
import '../../../Model/Machine/machine.dart';

class Statistics extends StatefulWidget {
  final Machine machine;

  const Statistics({super.key, required this.machine});

  @override
  State<Statistics> createState() => _Statistics();
}

class _Statistics extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Statistics",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline)),
            Text("Machine identifier: ${widget.machine.id}",
                style: const TextStyle(fontSize: 25)),
            Text("Machine name: ${widget.machine.name}",
                style: const TextStyle(fontSize: 25)),
            Text("Average minute production goal: ${widget.machine.productionGoal}",
                style: const TextStyle(fontSize: 25)),
            Text("Time before sending data: ${(widget.machine.sendingTime)/1000} seconds",
                style: const TextStyle(fontSize: 25)),
            Text("Total production: notImplemented",
                style: const TextStyle(fontSize: 25)),
            Text("Average daily production: notImplemented /minute",
                style: const TextStyle(fontSize: 25)),
            Text("Average hour production: notImplemented/minute",
                style: const TextStyle(fontSize: 25)),
            Text("Start hour: notImplemented",
                style: const TextStyle(fontSize: 25)),
            Text("Time inactivity: notImplemented",
                style: const TextStyle(fontSize: 25)),
          ],
        ),
      ),
    );
  }
}
