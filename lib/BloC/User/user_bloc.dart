import 'package:b3q1_hakem_projet_flutter/BloC/User/user_event.dart';
import 'package:b3q1_hakem_projet_flutter/BloC/User/user_state.dart';
import 'package:b3q1_hakem_projet_flutter/Firebase/Repositories/user_repository.dart';
import 'package:b3q1_hakem_projet_flutter/Model/User/user.dart';
import 'package:bloc/bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserRepository userRepository})
      : super(UserInitialState()) {

    on<UserLoginEvent>((event, emit) async {
      //Launching connection to firebase
      emit(UserLoadingState());
      try {
        await userRepository.signIn(event.email, event.password);
        if (await userRepository.getUser() == "") {
          emit(UserLoadedState(User(name: "Visitor", logged: false)));
        } else {
          emit(UserLoadedState(
              User(name: await userRepository.getUser(), logged: true)));
        }
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });

    on<FetchUserEvent>((event, emit) async {
      //Get user from firebase
      emit(UserLoadingState());
      try {
        if (await userRepository.getUser() == "") {
          emit(UserLoadedState(User(name: "Visitor", logged: false)));
        } else {
          emit(UserLoadedState(
              User(name: await userRepository.getUser(), logged: true)));
        }
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });

    on<UserResetPasswordEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        await userRepository.resetPassword(event.email);
        emit(UserLoadedState(User(name: "Visitor", logged: false)));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });

    on<UserLogoutEvent>((event, emit) {
      emit(UserLoadingState());
      try {
        userRepository.signOut();
        emit(UserLoadedState(User(name: "Visitor", logged: false)));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
