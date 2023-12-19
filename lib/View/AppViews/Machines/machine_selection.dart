import 'package:b3q1_hakem_projet_flutter/Firebase/Repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../BloC/Machines/machines_bloc.dart';
import '../../../BloC/Machines/machines_event.dart';
import '../../../BloC/Machines/machines_state.dart';
import '../../../Model/Machine/machine.dart';
import '../../../Model/User/user.dart';

class MachineSelection extends StatefulWidget {
  final UserRepository userRepository;

  const MachineSelection({super.key, required this.userRepository});

  @override
  State<MachineSelection> createState() => _MachineSelection();
}

class _MachineSelection extends State<MachineSelection> {
  late final User currentUser;

  late String username;
  late List<Machine> machines;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    BlocProvider.of<MachinesBloc>(context).add(LoadMachinesEvent());
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
              Machine(
                  id: 1,
                  productionGoal: 15,
                  sendingTime: 60000,
                  name: "Machine Schaeffer 1"),
              Machine(
                  id: 2,
                  productionGoal: 15,
                  sendingTime: 60000,
                  name: "Machine Schaeffer 2"),
              Machine(
                  id: 3,
                  productionGoal: 15,
                  sendingTime: 60000,
                  name: "Machine Schaeffer 3"),
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
                              title: const Text('Log in'),
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/login', (route) => false);
                              },
                            )
                          : Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.logout),
                                  title: const Text('Log out'),
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

              //Construct a bloc builder with the machinesBloc and machinesState
              //to load the machines

              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BlocBuilder<MachinesBloc, MachinesState>(
                      builder: (context, state) {
                        if (state is MachinesInitialState) {
                          return const Text('Initial State');
                        } else if (state is MachinesLoadingState) {
                          return const CircularProgressIndicator();
                        } else if (state is MachinesLoadedState) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: state.machines.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(
                                      state.machines[index].name,
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          '/machineDetail/${state.machines[index].id}');
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (state is MachinesErrorState) {
                          return Text(
                              'Une erreur est survenue: ${state.error}');
                        } else {
                          return const Text('Une erreur est survenue');
                        }
                      },
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
