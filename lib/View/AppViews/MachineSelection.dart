import 'package:b3q1_hakem_projet_flutter/View/AppViews/MachineDetail.dart';
import 'package:flutter/material.dart';
import '../../Model/Machine.dart';
import '../../Model/User.dart';

class MachineSelection extends StatefulWidget {
  const MachineSelection({super.key, required this.title});

  final String title;

  @override
  State<MachineSelection> createState() => _MachineSelection();
}

class _MachineSelection extends State<MachineSelection> {
  late User currentUser;

  late List<Machine> machines;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? userFromArgs = ModalRoute.of(context)?.settings.arguments as User?;
    if(userFromArgs != null) {
      currentUser = userFromArgs;
    } else {
      currentUser = User(name: 'Théo', logged: true);
    }
    machines = [
      Machine("Machine Schaeffer 1", 1, 1),
      Machine("Machine Schaeffer 2", 2, 1),
      Machine("Machine Schaeffer 3", 3, 1),
    ];

    void addMachine() {
      Navigator.pushNamed(
          context,
          '/add'
          );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title} - ${currentUser.name}"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF00B4D8),
                Color(0xFF48CAE4),
                Color(0xFF90E0EF),
                Color(0xFFADE8F4),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Select a machine',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                for (Machine machine in machines)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MachineDetail(),
                            settings: RouteSettings(
                              arguments: machine,
                            ),
                          ),
                        );
                      },
                      child: Text(machine.getName()),
                    ),
                  ),
                const SizedBox(height: 30)
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addMachine();
          },
          child: const Icon(Icons.add)),
    );
  }
}
