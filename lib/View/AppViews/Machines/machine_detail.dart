import 'package:b3q1_hakem_projet_flutter/View/Performance/Chart/chart.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/Group/grouped_informations.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/Performance/performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../BloC/Machine/machine_bloc.dart';
import '../../../BloC/Machine/machine_event.dart';
import '../../../BloC/Machine/machine_state.dart';
import '../../../BloC/Machines/machines_bloc.dart';
import '../../../BloC/Machines/machines_event.dart';
import '../../../BloC/User/user_bloc.dart';
import '../../../BloC/User/user_event.dart';
import '../../../BloC/User/user_state.dart';
import '../../../Model/Machine/machine.dart';
import '../../../Model/User/user.dart';
import '../../Performance/Stats/statistics.dart';

enum Views { textual, performance, chart, all }

class MachineDetail extends StatefulWidget {
  final String id;

  const MachineDetail({super.key, required this.id});

  @override
  State<MachineDetail> createState() => _MachineDetail();
}

class _MachineDetail extends State<MachineDetail> {
  Views selectedView = Views.textual;
  late UserBloc _userBloc;
  late MachineBloc _machineBloc;
  late Machine machine;

  bool loaded = false;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    if (currentUser == null) {
      _userBloc.add(FetchUserEvent());
    }
    _machineBloc = BlocProvider.of<MachineBloc>(context);
    _machineBloc.add(FetchMachineEvent(widget.id));
  }

  void setView(Views view) {
    setState(() {
      selectedView = view;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        bloc: _userBloc,
        buildWhen: (previous, current) {
          return previous != current;
        },
        builder: (context, state) {
          if (state is UserLoadedState) {
            currentUser = state.user;
          } else if (state is UserErrorState) {
            return const Text('Une erreur est survenue');
          }
          return BlocBuilder<MachineBloc, MachineState>(
            bloc: _machineBloc,
            buildWhen: (previous, current) {
              return previous != current;
            },
            builder: (context, state) {
              if (state is MachineInitialState) {
                return const CircularProgressIndicator();
              } else if (state is MachineLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is MachineLoadedState) {
                machine = state.machine;
              } else if (state is MachineErrorState) {
                return const Text('Une erreur est survenue');
              }
              return Scaffold(
                appBar: AppBar(
                  title: Text("Machine detail for id : ${widget.id}"),
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
                        currentUser == null || !currentUser!.logged
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
                                      _userBloc.add(UserLogoutEvent());
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/login', (route) => false);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.edit),
                                    title: const Text('Update a machine'),
                                    onTap: () async {
                                      await Navigator.pushNamed(
                                          context, '/update/${widget.id}');
                                      _machineBloc
                                          .add(FetchMachineEvent(widget.id));
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.add),
                                    title: const Text('Add a machine'),
                                    onTap: () async {
                                      await Navigator.pushNamed(
                                          context, '/add');
                                      BlocProvider.of<MachinesBloc>(context)
                                          .add(FetchMachinesEvent());
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
                                              BlocProvider.of<MachineBloc>(
                                                      context)
                                                  .add(DeleteMachineEvent(
                                                      widget.id));
                                              BlocProvider.of<MachinesBloc>(context)
                                                  .add(FetchMachinesEvent());
                                              Navigator.pushNamedAndRemoveUntil(context, "/machineSelection", (route) => false);
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
                          Statistics(machine: machine),
                        if (selectedView == Views.performance)
                          Performance(machine: machine),
                        if (selectedView == Views.chart)
                          Chart(machine: machine),
                        if (selectedView == Views.all)
                          GroupedInformations(machine: machine),
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
                ),
              );
            },
          );
        });
  }
}
