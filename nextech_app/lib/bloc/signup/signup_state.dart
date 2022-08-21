import 'package:nextech_app/bloc/login/form_submission_status.dart';

class SignupState {
  final String email;
  final String passwordFirst;
  final String passwordSecond;
  final String username;
  final String firstName;
  final String lastName;
  FormSubmissionStatus formStatus;

  bool get isValidEmail => email.length > 3;
  bool get isValidPassword => passwordFirst.length > 6;
  bool get isValidUsername => username.length > 3;
  bool get isValidSecondPass => passwordSecond == passwordFirst;
  //clubs
  SignupState(
      {this.email = '',
      this.passwordFirst = '',
      this.passwordSecond = '',
      this.username = '',
      this.firstName = '',
      this.lastName = '',
      this.formStatus = const InitialFormStatus()});

  SignupState copyWith(
      {String? email,
      String? passwordFirst,
      String? passwordSecond,
      String? username,
      String? firstName,
      String? lastName,
      FormSubmissionStatus? formStatus}) {
    return SignupState(
      email: email ?? this.email,
      passwordFirst: passwordFirst ?? this.passwordFirst,
      passwordSecond: passwordSecond ?? this.passwordSecond,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
