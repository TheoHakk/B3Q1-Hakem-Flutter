import 'package:b3q1_hakem_projet_flutter/Model/Machine/machine.dart';
import 'package:b3q1_hakem_projet_flutter/View/Forms/form_machine.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/Chart/chart.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/Group/grouped_informations.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/Performance/performance.dart';
import 'package:flutter/material.dart';

import '../../../Firebase/Repositories/user_repository.dart';
import '../../../Model/User/user.dart';
import '../../Performance/Stats/statistics.dart';

enum Views { textual, performance, chart, all }

class MachineDetail extends StatefulWidget {
  final String? machineId;
  final UserRepository userRepository;

  const MachineDetail(
      {super.key, required this.machineId, required this.userRepository});

  @override
  State<MachineDetail> createState() => _MachineDetail();
}

class _MachineDetail extends State<MachineDetail> {
  //Here we have a real bordel.
  //Because of the way we have to load the data, we have to use a FutureBuilder
  //to load the data, and then we have to use a setState to update the state
  //of the widget. This is not the best way to do it, but it works.
  //We have to do this because of the using of the async way to obtain the current user.
  //So we have to use a FutureBuilder to load the data and then construct the widget.

  Views selectedView = Views.textual;

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

  void setView(Views view) {
    setState(() {
      selectedView = view;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _loadUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Machine machine = Machine(8, "name", 8, 60000);
            return Scaffold(
                appBar: AppBar(
                  title: Text("Machine detail for id : ${widget.machineId}"),
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
                                  ListTile(
                                    leading: const Icon(Icons.delete),
                                    title: const Text('Delete machine'),
                                    onTap: () {
                                      AlertDialog alert = AlertDialog(
                                        title: const Text("Delete machine"),
                                        content: const Text(
                                            "Are you sure you want to delete this machine?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Delete"),
                                          ),
                                        ],
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                      ])
                    ],
                  ),
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (selectedView == Views.textual)
                          Statistics(title: "Statistics", machine: machine),
                        if (selectedView == Views.performance)
                          const Performance(title: "Les perfs ! "),
                        if (selectedView == Views.chart) Chart(),
                        if (selectedView == Views.all)
                          const GroupedInformations(title: "Ceci est un titre"),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: BottomAppBar(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.text_decrease),
                        label: Text(MediaQuery.of(context).size.width > 700
                            ? "Textual informations"
                            : ''),
                        onPressed: () {
                          setView(Views.textual);
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              selectedView == Views.textual
                                  ? Colors.blue
                                  : Colors.grey),
                        ),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.speed),
                        label: Text(MediaQuery.of(context).size.width > 700
                            ? "Speed'O'Meter"
                            : ''),
                        onPressed: () {
                          setView(Views.performance);
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              selectedView == Views.performance
                                  ? Colors.blue
                                  : Colors.grey),
                        ),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.bar_chart),
                        label: Text(MediaQuery.of(context).size.width > 700
                            ? 'Evolutive chart'
                            : ''),
                        onPressed: () {
                          setView(Views.chart);
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              selectedView == Views.chart
                                  ? Colors.blue
                                  : Colors.grey),
                        ),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.border_all),
                        //Set the visibility to non if screen is too small
                        label: Text(MediaQuery.of(context).size.width > 700
                            ? 'All informations'
                            : ''),
                        onPressed: () {
                          setView(Views.all);
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              selectedView == Views.all
                                  ? Colors.blue
                                  : Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
