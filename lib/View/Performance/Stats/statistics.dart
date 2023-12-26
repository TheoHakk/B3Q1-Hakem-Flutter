import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../BloC/Machine/machine_bloc.dart';
import '../../../BloC/Machine/machine_event.dart';
import '../../../BloC/Machine/machine_state.dart';

class Statistics extends StatefulWidget {
  final String id;
  final String title;

  const Statistics({super.key, required this.title, required this.id});

  @override
  State<Statistics> createState() => _Statistics();
}

class _Statistics extends State<Statistics> {
  Timer? _timer;
  int duration = 20;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    //Interruption of the actual timer, and creation of a new one
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: duration), (timer) {
      BlocProvider.of<MachineBloc>(context).add(LoadMachineEvent(widget.id));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    void setDuration(int sendingTime) {
      int newDuration = (sendingTime / 1000) as int;
      if (newDuration != duration) {
        duration = newDuration;
        startTimer();
      }
    }
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<MachineBloc, MachineState>(
              builder: (context, state) {
                if (state is MachineLoadingState) {
                  return const CircularProgressIndicator();
                } else if (state is MachineLoadedState) {
                  setDuration(state.machine.sendingTime);
                  return Column(
                    children: [
                      const Text("Statistics", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                      Text("Machine id: ${state.machine.id}",
                          style: const TextStyle(fontSize: 20)),
                      Text("Machine name: ${state.machine.name}",
                          style: const TextStyle(fontSize: 20)),
                      Text(
                          "Average minute production goal: ${state.machine.productionGoal}",
                          style: const TextStyle(fontSize: 20)),
                      Text(
                          "Average daily production: notImplemented /minute",
                          style: const TextStyle(fontSize: 20)),
                      Text(
                          "Average hour production: notImplemented/minute",
                          style: const TextStyle(fontSize: 20)),
                      Text("Start hour: notImplemented",
                          style: const TextStyle(fontSize: 20)),
                      Text(
                          "Time inactivity: notImplemented",
                          style: const TextStyle(fontSize: 20)),
                    ],
                  );
                } else {
                  return const Text("Error");
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}
