abstract class SignUpEvent{}


class SignUpEmailChanged extends SignUpEvent{
  final String email;
  SignUpEmailChanged(this.email);
}

class SignUpPasswordFirstChanged extends SignUpEvent{
  final String passwordFirst;
  SignUpPasswordFirstChanged(this.passwordFirst);
}

class SignUpPasswordSecondChanged extends SignUpEvent{
  final String password;
  SignUpPasswordSecondChanged(this.password);
}

class SignUpUsernameChanged extends SignUpEvent{
  final String username;
  SignUpUsernameChanged(this.username);
}

class SignUpFirstNameChanged extends SignUpEvent{
  final String firstName;
  SignUpFirstNameChanged(this.firstName);
}

class SignUpLastNameChanged extends SignUpEvent{
  final String lastName;
  SignUpLastNameChanged(this.lastName);
}





class SignUpDone extends SignUpEvent{
  
}

class SignUpSubmitted extends SignUpEvent{
  final String email;
  final String passwordFirst;
  final String passwordSecond;
  final String username;
  final String firstName;
  final String lastName;
  SignUpSubmitted(this.email, this.passwordFirst, this.passwordSecond, this.username, this.firstName, this.lastName);
}