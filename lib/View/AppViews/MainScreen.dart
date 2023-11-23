import 'package:b3q1_hakem_projet_flutter/Model/Machine.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/Statistics.dart';
import 'package:flutter/cupertino.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Machine machine;

  @override
  Widget build(BuildContext context) {
    machine = (ModalRoute.of(context)?.settings.arguments as Machine?)!;
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Statistics(title: "Statistics", machine: machine)]);
  }
}
