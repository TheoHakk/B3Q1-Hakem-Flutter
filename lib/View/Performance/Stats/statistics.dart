import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../BloC/Machine/machine_bloc.dart';
import '../../../BloC/Machine/machine_event.dart';
import '../../../BloC/Machine/machine_state.dart';
import '../../../Model/Machine/machine.dart';

class Statistics extends StatefulWidget {
  final String machineId;

  const Statistics({super.key, required this.machineId});

  @override
  State<Statistics> createState() => _Statistics();
}

class _Statistics extends State<Statistics> {
  Timer? _timer;
  int duration = 10;
  late MachineBloc _machineBloc;

  final StreamController<Machine> _machineStreamController = StreamController.broadcast();


  @override
  void initState() {
    super.initState();
    _machineBloc = BlocProvider.of<MachineBloc>(context);

    if (widget.machineId != 'null') {
      _machineBloc.add(LoadMachineEvent(widget.machineId));
    }

    _timer = Timer.periodic(Duration(seconds: duration), (timer) {
      if(widget.machineId != 'null') {
        _machineBloc.add(LoadMachineEvent(widget.machineId));
      }
    });

    _machineBloc.stream.listen((state) {
      if (state is MachineLoadedState) {
        _machineStreamController.add(state.machine);
      }
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

  Widget _buildStatisticsColumn(Machine machine) {
    return Column(
      children: [
        const Text("Statistics",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
        Text("Machine identifier: ${machine.id}", style: const TextStyle(fontSize: 20)),
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
