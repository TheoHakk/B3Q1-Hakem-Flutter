import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../BloC/Machines/machines_bloc.dart';
import '../../../BloC/Machines/machines_event.dart';
import '../../../BloC/Machines/machines_state.dart';
import '../../../BloC/User/user_bloc.dart';
import '../../../BloC/User/user_event.dart';
import '../../../BloC/User/user_state.dart';
import '../../../Model/User/user.dart';

class MachineSelection extends StatefulWidget {
  const MachineSelection({super.key});

  @override
  State<MachineSelection> createState() => _MachineSelection();
}

class _MachineSelection extends State<MachineSelection> {
  late UserBloc _userBloc;
  late MachinesBloc _machinesBloc;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    _machinesBloc = BlocProvider.of<MachinesBloc>(context);

    _loadUserData();

    _machinesBloc.add(FetchMachinesEvent());
  }

  void _loadUserData() {
    if (currentUser == null) {
      _userBloc.add(FetchUserEvent());
    }
  }

  @override
  void didChangeDependencies() {
    //actualise the bloc when adding a machine, work also for the machine bloc
    super.didChangeDependencies();
    _machinesBloc.add(FetchMachinesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        bloc: _userBloc,
        builder: (context, state) {
          if (state is UserLoadedState) {
            currentUser = state.user;
          } else if (state is UserErrorState) {
            return const Text('Une erreur est survenue');
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  "Machine selection - ${currentUser != null ? currentUser!.name : 'Loading...'}"),
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
            //#region Drawer
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
                                //permit to add a machine, and reload the list
                                leading: const Icon(Icons.add),
                                title: const Text('Add a machine'),
                                onTap: () async {
                                  await Navigator.pushNamed(context, '/add');
                                  //reload the bloc
                                  BlocProvider.of<MachinesBloc>(context)
                                      .add(FetchMachinesEvent());
                                },
                              ),
                            ],
                          ),
                  ])
                ],
              ),
            ),
            //#endregion
            //#region List of machines
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
                        return Text('Une erreur est survenue: ${state.error}');
                      } else {
                        return const Text('Une erreur est survenue');
                      }
                    },
                  ),
                ],
              ),
            ),
            //#endregion
          );
        });
  }
}
