import 'package:b3q1_hakem_projet_flutter/View/Performance/Chart/chart.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/Performance/performance.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/Stats/statistics.dart';
import 'package:flutter/material.dart';

import '../../../Model/Machine/machine.dart';

class GroupedInformations extends StatefulWidget {
  const GroupedInformations({super.key, required this.title});

  final String title;

  @override
  State<GroupedInformations> createState() => _GroupedInformations();
}

class _GroupedInformations extends State<GroupedInformations> {
  Machine awesomeMachine = Machine("name", 8, 8);

  @override
  build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 700) {
        return SingleChildScrollView(
          child: Column(children: <Widget>[
            Statistics(title: "title", machine: awesomeMachine),
            const Performance(title: "Perf"),
            SizedBox(width: constraints.maxWidth, child: Chart())
          ]),
        );
      }
      return SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Statistics(title: "title", machine: awesomeMachine),
            Column(
              children: [
                const Performance(title: "Perf"),
                SizedBox(width: constraints.maxWidth / 2, child: Chart())
              ],
            )
          ],
        ),
      );
    });
  }
}
