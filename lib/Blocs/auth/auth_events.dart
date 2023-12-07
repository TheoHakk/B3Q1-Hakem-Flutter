abstract class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  final String username;
  final String password;
  AuthEventLogin(this.username, this.password);
}

class AuthEventLogout extends AuthEvent {}
