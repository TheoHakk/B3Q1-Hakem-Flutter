import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../BloC/Machine/machine_bloc.dart';
import '../../../BloC/Machine/machine_event.dart';
import '../../../BloC/Machine/machine_state.dart';
import '../../../Model/Machine/machine.dart';

class Statistics extends StatelessWidget {
  final String machineId;
  const Statistics({super.key, required this.machineId});

  @override
  Widget build(BuildContext context) {
    final machineBloc = BlocProvider.of<MachineBloc>(context);
    if (machineId != 'null') {
      machineBloc.add(LoadMachineEvent(machineId));
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<MachineState>(
              stream: machineBloc.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  MachineState state = snapshot.data!;
                  if (state is MachineLoadedState) {
                    return _buildStatisticsColumn(state.machine);
                  } else {
                    return Text('Error not captured ${state.toString()}');
                  }
                } else {
                  return const Text('No data');
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsColumn(Machine machine) {
    return Column(
      children: [
        const Text("Statistics",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline)),
        Text("Machine identifier: ${machine.id}",
            style: const TextStyle(fontSize: 20)),
        Text("Machine name: ${machine.name}",
            style: const TextStyle(fontSize: 20)),
        Text("Average minute production goal: ${machine.productionGoal}",
            style: const TextStyle(fontSize: 20)),
        Text("Average daily production: notImplemented /minute",
            style: const TextStyle(fontSize: 20)),
        Text("Average hour production: notImplemented/minute",
            style: const TextStyle(fontSize: 20)),
        Text("Start hour: notImplemented",
            style: const TextStyle(fontSize: 20)),
        Text("Time inactivity: notImplemented",
            style: const TextStyle(fontSize: 20)),
      ],
    );
  }
}