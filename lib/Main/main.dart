import 'package:b3q1_hakem_projet_flutter/Firebase/Repositories/user_repository.dart';
import 'package:b3q1_hakem_projet_flutter/View/Forms/FormMachine.dart';
import 'package:flutter/material.dart';
import '../Firebase/Repositories/firebase_user_repository.dart';
import '../View/AppViews/MachineDetail.dart';
import '../View/AppViews/MachineSelection.dart';
import '../View/Login/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  UserRepository userRepository = FirebaseUserRepository();
  runApp(MyApp(userRepository: userRepository));
}



class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp({super.key, required this.userRepository});

  
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
        '/login': (context) => LoginPage(userRepository: userRepository),
        '/machineSelection': (context) => const MachineSelection(
            title: 'Machine selection'),
        '/machineDetail': (context) => const MachineDetail(),
        '/update' : (context) => const FormMachine(title: "update"),
        '/add' : (context) => const FormMachine(title: "add"),

      },
    );
  }
}
