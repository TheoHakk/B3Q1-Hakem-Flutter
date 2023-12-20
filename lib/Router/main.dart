import 'package:b3q1_hakem_projet_flutter/BloC/Machine/machine_bloc.dart';
import 'package:b3q1_hakem_projet_flutter/BloC/Machines/machines_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Firebase/Configuration/firebase_options.dart';
import '../Firebase/Repositories/firebase_user_repository.dart';
import '../Firebase/Repositories/user_repository.dart';
import '../View/AppViews/Machines/machine_detail.dart';
import '../View/AppViews/Machines/machine_selection.dart';
import '../View/AppViews/Error/not_found.dart';
import '../View/Forms/form_machine.dart';
import '../View/Login/login_page.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<MachinesBloc>(create: (context) => MachinesBloc()),
        BlocProvider<MachineBloc>(create: (context) => MachineBloc()),
      ],
      child: MaterialApp(
        title: 'Performance counter',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        onGenerateRoute: (settings) {
          //Extract id from the path
          var path = settings.name?.split('/');
          String? id = (path!.length > 2) ? path[2] : null;

          switch (path[1]) {
            case 'login':
              return MaterialPageRoute(
                  //we add the settings to the route, for actualize the url in the browser
                  settings: settings,
                  builder: (context) =>
                      LoginPage(userRepository: userRepository));
            case 'machineSelection':
              return MaterialPageRoute(
                  settings: settings,
                  builder: (context) =>
                      MachineSelection(userRepository: userRepository));
            case 'machineDetail':
              return MaterialPageRoute(
                  settings: settings,
                  builder: (context) => MachineDetail(
                      machineId: id, userRepository: userRepository));
            case 'update':
              return MaterialPageRoute(
                  settings: settings,
                  builder: (context) =>
                      FormMachine(title: "update", machineId: id, userRepository: userRepository));
            case 'add':
              return MaterialPageRoute(
                  settings: settings,
                  builder: (context) =>
                      FormMachine(title: "add", machineId: id, userRepository: userRepository));
            default:
              return MaterialPageRoute(
                  settings: settings,
                  builder: (context) => const NotFoundPage());
          }
        },
      ),
    );
  }
}
