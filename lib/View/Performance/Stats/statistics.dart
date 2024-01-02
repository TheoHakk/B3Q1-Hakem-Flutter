import 'package:flutter/material.dart';
import '../../../Model/Machine/machine.dart';

class Statistics extends StatelessWidget {
  final Machine machine;

  const Statistics({super.key, required this.machine});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildText("Statistics", 30, FontWeight.bold, TextDecoration.underline),
            buildText("Machine identifier: ${machine.id}", 25),
            buildText("Machine name: ${machine.name}", 25),
            buildText("Average minute production goal: ${machine.productionGoal}", 25),
            buildText("Time before sending data: ${(machine.sendingTime) / 1000} seconds", 25),
            buildText("Total production: ${(machine.totalProd).toString()}", 25),
            buildText("Average daily production:  ${(machine.averageProdDay).toString()} /minute", 25),
            buildText("Average hour production:  ${(machine.averageProdHour).toString()}/minute", 25),
            buildText("Start hour:  ${machine.startHour}", 25),
          ],
        ),
      ),
    );
  }

  Widget buildText(String data, double fontSize, [FontWeight fontWeight = FontWeight.normal, TextDecoration decoration = TextDecoration.none]) {
    return Text(data, style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, decoration: decoration));
  }
}