import 'package:b3q1_hakem_projet_flutter/Firebase/Repositories/user_repository.dart';
import 'package:b3q1_hakem_projet_flutter/View/AppViews/machine_detail.dart';
import 'package:flutter/material.dart';
import '../../Model/machine.dart';
import '../../Model/user.dart';

class MachineSelection extends StatefulWidget {
  final UserRepository userRepository;

  const MachineSelection({super.key, required this.userRepository});

  @override
  State<MachineSelection> createState() => _MachineSelection();
}

class _MachineSelection extends State<MachineSelection> {
  late User currentUser;

  late String username;
  late List<Machine> machines;

  @override
  void initState() {
    super.initState();
    widget.userRepository.getUser().then((value) {
      setState(() {
        username = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    if (username == "") {
      currentUser = User(name: 'Visitor', logged: false);
    } else {
      currentUser = User(name: username, logged: true);
    }

    machines = [
      Machine("Machine Schaeffer 1", 1, 1),
      Machine("Machine Schaeffer 2", 2, 1),
      Machine("Machine Schaeffer 3", 3, 1),
    ];

    void addMachine() {
      Navigator.pushNamed(context, '/add');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${"Machine selection"} - ${currentUser.name}"),
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
