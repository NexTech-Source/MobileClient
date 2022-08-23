import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextech_app/bloc/auth_repo.dart';
import 'package:nextech_app/bloc/login/form_submission_status.dart';
import 'package:nextech_app/bloc/login/login_bloc.dart';
import 'package:nextech_app/bloc/login/login_event.dart';
import 'package:nextech_app/bloc/login/login_state.dart';
import 'package:nextech_app/constants/app_colours.dart';
import 'package:nextech_app/constants/routes.dart';
import 'package:nextech_app/presentation/router.dart';


class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  //final _formKeySecond = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
          Image.asset(
            "assets/images/bacground_2.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 100,
             left: MediaQuery.of(context).size.width/2-200,
            child: Image.asset(
              "assets/images/login.png",
              height: 600,
              width: 400,
             
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/inde752.png",
              height: 100,
              width: 100,
                  
              
            ),
          ),
        
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/images/sihlogo2.png",
              height: 100,
              width: 100,
              
            ),
          ),
          
        Positioned(
      
          child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocProvider(
            create: (context) => LoginBloc(
              authRepo: context.read<AuthRepository>(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Builder(builder: (context) {
                  return _loginForm(context);
                }),
              ],
            ),
          ),
              ),
        )],
    );
  }

  Widget _loginForm(context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            emailController.clear();
            passwordController.clear();
            _showSnackBar(context, formStatus.exception);
            state.formStatus = const InitialFormStatus();
          }
          if (formStatus is SubmissionSuccess) {
            Navigator.of(context)
                .popAndPushNamed(AppRouter().runTimeRouteGenerator());
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             
              Center(
                child: SizedBox(
                    width: 300, height: 300, child: _loginContainer(context)),
              ),
            

            ],
          ),
        ));
  }

  Widget _loginContainer(context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: kLightTransPurple,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 250, child: _emailField()),
              const Padding(padding: EdgeInsets.only(top: 20)),
              SizedBox(width: 250, child: _passwordField()),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _loginButton(),
              _signUpText(),
              //_forgotPasswordText(context)
            ]));
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          icon: Icon(Icons.email_outlined),
          hintText: 'Email-id',
        ),
        validator: (value) => state.isValidEmail ? null : 'Email is too short',
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginEmailChanged(value),
            ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        controller: passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          icon: Icon(Icons.security),
          hintText: 'Password',
        ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is too short',
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginPasswordChanged(value),
            ),
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(LoginSubmitted());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kPurpleColour, onPrimary: kWhite
                    ),
                   
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
                          "Login",
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
    Widget _signUpText() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      TextStyle defaultStyle =
          const TextStyle(color: Color.fromARGB(255, 109, 109, 109), fontSize: 20.0);
      TextStyle linkStyle = const TextStyle(color: Colors.blue);
      return RichText(
        text: TextSpan(
          style: defaultStyle,
          children: <TextSpan>[
            const TextSpan(text: 'Don\'t have an account? '),
            TextSpan(
                text: 'SignUp',
                style: linkStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushNamed(kRegisterRoute);
                  }),
          ],
        ),
      );
    });
  }


  void dispose() {
    passwordController.dispose();
    emailController.dispose();
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: const Color.fromARGB(255, 82, 8, 8),
    );
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(snackBar);
  }




}
