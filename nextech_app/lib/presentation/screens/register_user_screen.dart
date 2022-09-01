import 'package:nextech_app/bloc/login/form_submission_status.dart';
import 'package:nextech_app/bloc/signup/signup_bloc.dart';
import 'package:nextech_app/bloc/signup/signup_event.dart';
import 'package:nextech_app/bloc/signup/signup_state.dart';
import 'package:nextech_app/bloc/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:nextech_app/constants/app_colours.dart';
import 'package:nextech_app/constants/routes.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordFirstController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordSecondController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         Image.asset(
            "assets/images/background_4.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: kBlueNCS,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (context) => SignUpBloc(
                authRepo: context.read<AuthRepository>(),
              ),
              child: _signUpForm(),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignupState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            emailController.clear();
            passwordFirstController.clear();
            passwordSecondController.clear();
            usernameController.clear();
            firstNameController.clear();
            lastNameController.clear();
            _showSnackBar(context, formStatus.exception, kErrorColorDark);
            state.formStatus = const InitialFormStatus();
            _showSnackBar(
                context,
                'Sign Up request failed. Please try again later.',
                kErrorColorDark);
          }
          if (formStatus is SubmissionSuccess) {
            _showSnackBar(
                context, 'Sign Up request successful', kGreenSentinel);
            Navigator.of(context).pushReplacementNamed(kLoginRoute);
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NeumorphicText(
                    'Register',
                    style: NeumorphicStyle(
                      color: kBlueNCS,
                      depth: 1,
                    ),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 550, child: _signUpContainer()),
            ],
          ),
        ));
  }

  Widget _signUpContainer() {
    return BlocBuilder<SignUpBloc, SignupState>(builder: (context, state) {
      return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: kLightOrange,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 300, child: _emailField()),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  SizedBox(width: 300, child: _passwordFirstField()),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  SizedBox(width: 300, child: _passwordSecondField()),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  SizedBox(width: 300, child: _usernameField()),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  SizedBox(width: 300, child: _firstNameField()),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  SizedBox(width: 300, child: _lastNameField()),
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  _signUpButton(),
                ]),
          ));
    });
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignupState>(builder: (context, state) {
      return TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          icon: Icon(Icons.email_outlined),
          hintText: 'Email-id',
        ),
        validator: (value) => state.isValidEmail ? null : 'Email is too short',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpEmailChanged(value),
            ),
      );
    });
  }

  Widget _passwordFirstField() {
    return BlocBuilder<SignUpBloc, SignupState>(builder: (context, state) {
      return TextFormField(
        controller: passwordFirstController,
        obscureText: true,
        decoration: const InputDecoration(
          icon: Icon(Icons.security),
          hintText: 'Password',
        ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is too short',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpPasswordFirstChanged(value),
            ),
      );
    });
  }

  Widget _passwordSecondField() {
    return BlocBuilder<SignUpBloc, SignupState>(builder: (context, state) {
      return TextFormField(
        controller: passwordSecondController,
        obscureText: true,
        decoration: const InputDecoration(
          icon: Icon(Icons.security),
          hintText: 'Confirm Password',
        ),
        validator: (value) =>
            state.isValidSecondPass ? null : "Passwords don't match!",
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpPasswordSecondChanged(value),
            ),
      );
    });
  }

  Widget _usernameField() {
    return BlocBuilder<SignUpBloc, SignupState>(builder: (context, state) {
      return TextFormField(
        controller: usernameController,
        decoration: const InputDecoration(
          icon: Icon(Icons.person_outline),
          hintText: 'Username',
        ),
        validator: (value) =>
            state.isValidUsername ? null : 'Username is too short',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpUsernameChanged(value),
            ),
      );
    });
  }

  Widget _firstNameField() {
    return BlocBuilder<SignUpBloc, SignupState>(builder: (context, state) {
      return TextFormField(
        controller: firstNameController,
        decoration: const InputDecoration(
          icon: Icon(Icons.person_outline),
          hintText: 'First Name',
        ),
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpFirstNameChanged(value),
            ),
      );
    });
  }

  Widget _lastNameField() {
    return BlocBuilder<SignUpBloc, SignupState>(builder: (context, state) {
      return TextFormField(
        controller: lastNameController,
        decoration: const InputDecoration(
          icon: Icon(Icons.person_outline),
          hintText: 'Last Name',
        ),
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpLastNameChanged(value),
            ),
      );
    });
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignupState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NeumorphicButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignUpBloc>().add(SignUpSubmitted(
                            emailController.text,
                            passwordFirstController.text,
                            passwordSecondController.text,
                            usernameController.text,
                            firstNameController.text == ""
                                ? usernameController.text
                                : firstNameController.text,
                            lastNameController.text));
                      }
                    },
                    style: NeumorphicStyle(
                      shadowDarkColor: kPurpleColourDarker,
                      shadowLightColor: kPurpleColour,
                      shape: NeumorphicShape.flat,
                      color: kGreenSentinel,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8)),
                      //border: NeumorphicBorder()
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: kWhite,
                          ),
                        ),
                        Text(
                          "SignUp",
                          style: TextStyle(
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
    });
  }

  //TODO: solve all the disposes in the bloc
  void dispose() {
    passwordFirstController.dispose();
    passwordSecondController.dispose();
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: color,
    );
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
