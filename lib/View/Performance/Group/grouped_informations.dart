import 'package:b3q1_hakem_projet_flutter/View/Performance/Chart/chart.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/Performance/performance.dart';
import 'package:flutter/material.dart';
import '../../../Model/Machine/machine.dart';
import '../Stats/statistics.dart';

class GroupedInformations extends StatefulWidget {
  const GroupedInformations({super.key, required this.id});

  final String id;

  @override
  State<GroupedInformations> createState() => _GroupedInformations();
}

class _GroupedInformations extends State<GroupedInformations> {
  final Machine awesomeMachine = Machine(
      id: 1,
      productionGoal: 15,
      sendingTime: 60000,
      name: "Machine Schaeffer 1");

  @override
  build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 750) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Statistics(id: widget.id),
              SizedBox(
                height: screenHeight * 0.4,
                child: const Performance(title: "Perf"),
              ),
              SizedBox(
                height: screenHeight * 0.4,
                child: SizedBox(width: constraints.maxWidth, child: Chart()),
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
            Statistics(id: widget.id),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: constraints.maxWidth / 2,
                  height: screenHeight * 0.4,
                  child: const Performance(title: "Perf"),
                ),
                SizedBox(
                  height: screenHeight * 0.4,
                  child:
                      SizedBox(width: constraints.maxWidth / 2, child: Chart()),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
