import 'package:b3q1_hakem_projet_flutter/Firebase/Repositories/user_repository.dart';
import 'package:flutter/material.dart';
import '../../../Model/Machine/machine.dart';
import '../../../Model/User/user.dart';

class MachineSelection extends StatefulWidget {
  final UserRepository userRepository;

  const MachineSelection({super.key, required this.userRepository});

  @override
  State<MachineSelection> createState() => _MachineSelection();
}

class _MachineSelection extends State<MachineSelection> {
  //Here we have a real bordel.
  //Because of the way we have to load the data, we have to use a FutureBuilder
  //to load the data, and then we have to use a setState to update the state
  //of the widget. This is not the best way to do it, but it works.
  //We have to do this because of the using of the async way to obtain the current user.
  //So we have to use a FutureBuilder to load the data and then construct the widget.

  late final User currentUser;

  late String username;
  late List<Machine> machines;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  bool isLoading = true;

  Future<void> _loadUserData() async {
    if (isLoading) {
      String name = await widget.userRepository.getUser();
      setState(() {
        username = name;
        isLoading = false; // Set loading to false after data is loaded
      });
      if (username == "") {
        currentUser = User(name: 'Visitor', logged: false);
      } else {
        currentUser = User(name: username, logged: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _loadUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            machines = [
              Machine("Machine Schaeffer 1", 1, 1),
              Machine("Machine Schaeffer 2", 2, 1),
              Machine("Machine Schaeffer 3", 3, 1),
            ];

            return Scaffold(
              appBar: AppBar(
                title: Text("Machine selection - ${currentUser.name}"),
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
              endDrawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF00B4D8),
                            Color(0xFF48CAE4),
                            Color(0xFF90E0EF),
                            Color(0xFFADE8F4),
                          ],
                        ),
                      ),
                      child: Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Column(children: [
                      !currentUser.logged
                          ? ListTile(
                              leading: const Icon(Icons.login),
                              title: const Text('Connection'),
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/login', (route) => false);
                              },
                            )
                          : Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.logout),
                                  title: const Text('Disconnection'),
                                  onTap: () {
                                    widget.userRepository.signOut();
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/login', (route) => false);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.add),
                                  title: const Text('Add a machine'),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/add');
                                  },
                                ),
                              ],
                            ),
                    ])
                  ],
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
                                Navigator.pushNamed(context,
                                    '/machineDetail/${machine.getId()}');
                              },
                              child: Text(machine.getName()),
                            ),
                          ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
