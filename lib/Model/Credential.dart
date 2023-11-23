class Credential {
  late String _username;
  late String _password;

  Credential() {
    _username = "";
    _password = "";
  }

  getUsername() {
    return _username;
  }

  getPassword() {
    return _password;
  }

  setUsername(String username) {
    _username = username;
  }

  setPassword(String password) {
    _password = password;
  }
}