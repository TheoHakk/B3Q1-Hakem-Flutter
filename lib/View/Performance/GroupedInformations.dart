import 'package:b3q1_hakem_projet_flutter/View/Performance/Graphic.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/Performance.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/Statistics.dart';
import 'package:flutter/material.dart';

import '../../Model/Machine.dart';

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
    return  Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Statistics(title: "title", machine: awesomeMachine)],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Performance(title:"title"), Chart()],
          ),
        ],
      ),
    );
  }
}
