import 'package:bloc/bloc.dart';
import 'package:nextech_app/bloc/auth_repo.dart';
import 'package:nextech_app/bloc/login/form_submission_status.dart';
import 'package:nextech_app/bloc/login/login_event.dart';
import 'package:nextech_app/bloc/login/login_state.dart';
import 'package:nextech_app/data/locator.dart';
import 'package:nextech_app/data/runtime_state.dart';

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
            runTimeState.get<AppRunTimeStatus>().currentEmail = state.email;
            emit(state.copyWith(formStatus: SubmissionSuccess()));
          } else {
            emit(state.copyWith(formStatus: SubmissionFailed(runTimeState.get<AppRunTimeStatus>().exceptionMessage)));
          }
        } catch (e) {
          emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
        }
      }
    }
  }
