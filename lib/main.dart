import 'package:b3q1_hakem_projet_flutter/BloC/Machine/machine_bloc.dart';
import 'package:b3q1_hakem_projet_flutter/BloC/Machines/machines_bloc.dart';
import 'package:b3q1_hakem_projet_flutter/BloC/Unit/last_unit_bloc.dart';
import 'package:b3q1_hakem_projet_flutter/BloC/Units/units_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'BloC/User/user_bloc.dart';
import 'BloC/User/user_state.dart';
import 'Firebase/Configuration/firebase_options.dart';
import 'Firebase/Repositories/firebase_user_repository.dart';
import 'Firebase/Repositories/user_repository.dart';
import 'View/AppViews/Machines/machine_detail.dart';
import 'View/AppViews/Machines/machine_selection.dart';
import 'View/AppViews/Error/not_found.dart';
import 'View/Forms/form_machine.dart';
import 'View/Login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  UserRepository userRepository = FirebaseUserRepository();
  UserBloc userBloc = UserBloc(userRepository: userRepository);

  runApp(MyApp(
    userRepository: userRepository,
    userBloc: userBloc,
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final UserBloc userBloc;

  const MyApp(
      {super.key, required this.userRepository, required this.userBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //#region BlocProviders
      providers: [
        BlocProvider<MachinesBloc>(create: (context) => MachinesBloc()),
        BlocProvider<MachineBloc>(create: (context) => MachineBloc()),
        BlocProvider<UnitsBloc>(create: (context) => UnitsBloc()),
        BlocProvider<UserBloc>.value(value: userBloc),
        BlocProvider<LastUnitBloc>(create: (context) => LastUnitBloc()),
      ],
      //#endregion
      child: MaterialApp(
        title: 'Performance counter',
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        //#region Routes
        onGenerateRoute: (settings) {
          //Extract id from the path
          var path = settings.name?.split('/');
          String? id = (path!.length > 2) ? path[2] : null;

          var userBloc = this.userBloc;

          switch (path[1]) {
            case 'login':
              return MaterialPageRoute(
                  //we add the settings to the route, for actualize the url in the browser
                  settings: settings,
                  builder: (context) => const LoginPage());
            case 'machineSelection':
              return MaterialPageRoute(
                  settings: settings,
                  builder: (context) => const MachineSelection());
            case 'machineDetail':
              return MaterialPageRoute(
                  settings: settings,
                  builder: (context) => MachineDetail(id: id.toString()));
            case 'update':
              if (userBloc.state is UserLoadedState &&
                  (userBloc.state as UserLoadedState).user.logged) {
                //verify if the user is connected
                return MaterialPageRoute(
                    settings: settings,
                    builder: (context) =>
                        FormMachine(title: "update", machineId: id));
              } else {
                //if not, redirect to the login page
                return MaterialPageRoute(
                    settings: settings,
                    builder: (context) => const LoginPage());
              }
            case 'add':
              if (userBloc.state is UserLoadedState &&
                  (userBloc.state as UserLoadedState).user.logged) {
                //verify if the user is connected
                return MaterialPageRoute(
                    settings: settings,
                    builder: (context) =>
                        const FormMachine(title: "add", machineId: null));
              } else {
                //if not, redirect to the login page
                return MaterialPageRoute(
                    settings: settings,
                    builder: (context) => const LoginPage());
              }
            default:
              return MaterialPageRoute(
                  settings: settings,
                  builder: (context) => const NotFoundPage());
          }
        },
        //#endregion
      ),
    );
  }
}
