import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../BloC/Machine/machine_bloc.dart';
import '../../../BloC/Machine/machine_event.dart';
import '../../../BloC/Machine/machine_state.dart';
import '../../../Model/Machine/machine.dart';

class Statistics extends StatefulWidget {
  final String id;

  const Statistics({super.key, required this.id});

  @override
  _Statistics createState() => _Statistics();
}

class _Statistics extends State<Statistics> {
  Timer? _timer;
  int duration = 10;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MachineBloc>(context).add(LoadMachineEvent(widget.id));
    _startTimer();
  }

  void _startTimer() {
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
  Widget build(BuildContext context) {
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
                  _updateTimerDuration(state.machine.sendingTime);
                  return _buildStatisticsColumn(state.machine);
                } else if (state is MachineErrorState) {
                  return const Text('Error while loading machine');
                } else {
                  return Text('Error not captured ${state.toString()}');
                }

              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateTimerDuration(int sendingTime) {
    int newDuration = (sendingTime / 1000).round();
    if (newDuration != duration) {
      duration = newDuration;
      _startTimer();
    }
  }

  Widget _buildStatisticsColumn(Machine machine) {
    return Column(
      children: [
        const Text("Statistics", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        Text("Machine id: ${machine.id}", style: const TextStyle(fontSize: 20)),
        Text("Machine name: ${machine.name}", style: const TextStyle(fontSize: 20)),
        Text("Average minute production goal: ${machine.productionGoal}", style: const TextStyle(fontSize: 20)),
        Text("Average daily production: notImplemented /minute", style: const TextStyle(fontSize: 20)),
        Text("Average hour production: notImplemented/minute", style: const TextStyle(fontSize: 20)),
        Text("Start hour: notImplemented", style: const TextStyle(fontSize: 20)),
        Text("Time inactivity: notImplemented", style: const TextStyle(fontSize: 20)),
      ],
    );
  }
}