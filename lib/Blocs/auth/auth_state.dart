abstract class AuthState {
}

class AuthStateAuthenticated extends AuthState {

  final String username;

  AuthStateAuthenticated(this.username);

}

class AuthStateUnauthenticated extends AuthState {
}