import '../../Model/User/user.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final User user;

  UserLoadedState(this.user);
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState(this.message);
}

