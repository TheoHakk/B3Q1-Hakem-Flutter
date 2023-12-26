import 'package:b3q1_hakem_projet_flutter/BloC/User/user_event.dart';
import 'package:b3q1_hakem_projet_flutter/BloC/User/user_state.dart';
import 'package:bloc/bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState>{

  UserBloc() : super(UnitsInitialState()) {

  }
}