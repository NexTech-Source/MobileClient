abstract class LoginEvent{}

class LoginEmailChanged extends LoginEvent{
   final String email;
  LoginEmailChanged(this.email);
}

class LoginPasswordChanged extends LoginEvent{
  final String password;
  LoginPasswordChanged(this.password);
}

class LoginSubmitted extends LoginEvent{
  
}

class GoogleLoginSubmitted extends LoginEvent{
  
}

class TwitterLoginSubmitted extends LoginEvent{
  
}

class GitHubLoginSubmitted extends LoginEvent{
  
}