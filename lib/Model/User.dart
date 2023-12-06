import 'dart:ffi';

class User {
  late String _name;
  late Bool _isLogged;
  late Bool _isAdmin;

  User(String name, Bool isLogged, Bool isAdmin) {
    _name = name;
    _isLogged = isLogged;
    _isAdmin = isAdmin;
  }

  String getName() {
    return _name;
  }

  Bool getIsLogged() {
    return _isLogged;
  }

  Bool getIsAdmin() {
    return _isAdmin;
  }
}
