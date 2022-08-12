import 'package:bloc/bloc.dart';
import 'package:nextech_app/bloc/auth_repo.dart';
import 'package:nextech_app/bloc/login/form_submission_status.dart';
import 'package:nextech_app/bloc/login/login_event.dart';
import 'package:nextech_app/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  LoginBloc({required this.authRepo}) : super(LoginState()) {
    on<LoginEvent>(_onEvent);
  }

    Future<void> _onEvent(LoginEvent event, Emitter<LoginState> emit) async {
      if (event is LoginEmailChanged) {
        emit(state.copyWith(email: event.email));
      }
      // password update
      else if (event is LoginPasswordChanged) {
        emit(state.copyWith(password: event.password));
      }
      //form submitted
      else if (event is LoginSubmitted) {
        emit(state.copyWith(formStatus: FormSubmitting()));

        try {
          bool issuccessful = await authRepo.login(state.email, state.password);
          if (issuccessful) {
            emit(state.copyWith(formStatus: SubmissionSuccess()));
          } else {}
        } catch (e) {
          emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
        }
      }
    }
  }
