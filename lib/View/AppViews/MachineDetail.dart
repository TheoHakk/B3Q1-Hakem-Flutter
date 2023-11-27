import 'package:b3q1_hakem_projet_flutter/Model/Machine.dart';
import 'package:b3q1_hakem_projet_flutter/View/Forms/FormMachine.dart';
import 'package:flutter/material.dart';

import '../Performance/Statistics.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  Machine machine = Machine("Machine Schaeffer 1", 1, 1);

  void updateMachine() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const FormMachine(title: "Update machine")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wouaw"),
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Delete machine'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Statistics(title: "Statistics", machine: machine),
            const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            updateMachine();
          },
          child: const Icon(Icons.settings)),
    );
  }
}
