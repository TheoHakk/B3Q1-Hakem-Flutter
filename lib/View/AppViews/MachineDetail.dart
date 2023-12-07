import 'package:b3q1_hakem_projet_flutter/Model/Machine.dart';
import 'package:b3q1_hakem_projet_flutter/View/Forms/FormMachine.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/Graphic.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/GroupedInformations.dart';
import 'package:b3q1_hakem_projet_flutter/View/Performance/Performance.dart';
import 'package:flutter/material.dart';

import '../Performance/Statistics.dart';

enum Views { textual, performance, chart, all }

class MachineDetail extends StatefulWidget {
  const MachineDetail({Key? key}) : super(key: key);

  @override
  State<MachineDetail> createState() => _MachineDetail();
}

class _MachineDetail extends State<MachineDetail> {

  Views selectedView = Views.textual;

  void updateMachine() {
    Navigator.pushNamed(
        context,
        '/update'
        );
  }

  void setView(Views view) {
    setState(() {
      selectedView = view;
    });
  }

  @override
  Widget build(BuildContext context) {
    Machine machine = (ModalRoute.of(context)?.settings.arguments as Machine?)!;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Machine detail"),
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
              ListTile(
                title: const Text('Update machine'),
                onTap: () {
                  updateMachine();
                },
              ),
              ListTile(
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
        ),
        body: Center(
          child: Column(
            children: [
              if (selectedView == Views.textual)
                Statistics(title: "Statistics", machine: machine),
              if (selectedView == Views.performance)
                const Performance(title: "Les perfs ! "),
              if (selectedView == Views.chart)
                Chart(),
              if (selectedView == Views.all)
                const GroupedInformations(title: "Ceci est un titre"),
              const SizedBox(height: 30),
            ],
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
                          : Colors.grey
                  ),
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
  }
}
