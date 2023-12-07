import 'package:b3q1_hakem_projet_flutter/View/Forms/FormMachine.dart';
import 'package:flutter/material.dart';
import '../AppViews/MachineDetail.dart';
import '../AppViews/MachineSelection.dart';
import '../Login/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Performance counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(title: 'Connection page'),
        '/machineSelection': (context) => const MachineSelection(
            title: 'Machine selection'),
        '/machineDetail': (context) => const MachineDetail(),
        '/update' : (context) => const FormMachine(title: "update"),
        '/add' : (context) => const FormMachine(title: "add"),

      },
    );
  }
}
