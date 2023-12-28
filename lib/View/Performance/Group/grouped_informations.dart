import 'package:b3q1_hakem_projet_flutter/View/Performance/Chart/chart.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/Performance/performance.dart';
import 'package:flutter/material.dart';
import '../Stats/statistics.dart';

class GroupedInformations extends StatefulWidget {
  const GroupedInformations({super.key, required this.machineId});

  final String machineId;

  @override
  State<GroupedInformations> createState() => _GroupedInformations();
}

class _GroupedInformations extends State<GroupedInformations> {
  @override
  build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 750) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Statistics(machineId: widget.machineId),
              SizedBox(
                height: screenHeight * 0.4,
                child: Performance(machineId: widget.machineId),
              ),
              SizedBox(
                height: screenHeight * 0.4,
                child: SizedBox(
                    width: constraints.maxWidth,
                    child: Chart(machineId: widget.machineId)),
              )
            ],
          ),
        );
      }
      return Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Statistics(machineId: widget.machineId),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: constraints.maxWidth / 2,
                  height: screenHeight * 0.4,
                  child: Performance(machineId: widget.machineId),
                ),
                SizedBox(
                  height: screenHeight * 0.4,
                  child: SizedBox(
                      width: constraints.maxWidth / 2,
                      child: Chart(machineId: widget.machineId)),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
