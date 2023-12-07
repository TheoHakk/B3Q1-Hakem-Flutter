import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_events.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateUnauthenticated()) {
    // connection à Firebase
    // j'écoute le stream des utilisateurs connectés
    // à chaque fois que le stream émet un événement (listen sur mon stream...)
    // j'envoie un événement à mon bloc (add d'un événement sur mon bloc)

    // .snapshots().listen((state) {
    //   if (state.hasData) {
    //      emit(AuthStateAuthenticated(state.data!.username));
    //   } else {
    //     emit(AuthStateUnauthenticated());
    //   }
    //});
    on<AuthEventLogin>((event, emit) {
      if (event.password == 'magicPassword') {
        emit(AuthStateAuthenticated(event.username));
      } else {
        emit(AuthStateUnauthenticated());
      }
    });
    on<AuthEventLogout>((event, emit) {
      emit(AuthStateUnauthenticated());
    });
  }
}
