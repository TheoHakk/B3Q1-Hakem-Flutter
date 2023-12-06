import 'package:flutter/material.dart';

import '../../Model/Machine.dart';

class Performance extends StatefulWidget {
  const Performance({super.key, required this.title});

  final String title;

  @override
  State<Performance> createState() => _Performance();
}

class _Performance extends State<Performance> {
  late Machine machine;


  @override
  build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Performance',
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
