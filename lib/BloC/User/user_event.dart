abstract class UserEvent{}

class UserLoginEvent extends UserEvent{
  final String email;
  final String password;

  UserLoginEvent(this.email, this.password);
}


class UserLogoutEvent extends UserEvent{
}

class FetchUserEvent extends UserEvent{}

class UserResetPasswordEvent extends UserEvent{
  final String email;

  UserResetPasswordEvent(this.email);
}



