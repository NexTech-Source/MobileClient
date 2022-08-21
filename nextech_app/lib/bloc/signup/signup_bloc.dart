import 'package:nextech_app/bloc/login/form_submission_status.dart';
import 'package:bloc/bloc.dart';
import 'package:nextech_app/bloc/auth_repo.dart';
import 'package:nextech_app/bloc/signup/signup_event.dart';
import 'package:nextech_app/bloc/signup/signup_state.dart';
import 'package:nextech_app/data/locator.dart';
import 'package:nextech_app/data/models/model_exports.dart';
import 'package:nextech_app/data/runtime_state.dart';
import 'package:nextech_app/storage/hive_local_storage.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignupState> {
  final AuthRepository authRepo;
  SignUpBloc({required this.authRepo}) : super(SignupState()) {
    on<SignUpEvent>(_onEvent);
  }

  Future<void> _onEvent(SignUpEvent event, Emitter<SignupState> emit) async {
    if (event is SignUpEmailChanged) {
      emit(state.copyWith(email: event.email));
    }
    // password update
    else if (event is SignUpPasswordFirstChanged) {
      emit(state.copyWith(passwordFirst: event.passwordFirst));
    } else if (event is SignUpPasswordSecondChanged) {
      emit(state.copyWith(passwordSecond: event.password));
    }
    // username update
    else if (event is SignUpUsernameChanged) {
      emit(state.copyWith(username: event.username));
    }
    // first name update
    else if (event is SignUpFirstNameChanged) {
      emit(state.copyWith(firstName: event.firstName));
    }
    // last name update
    else if (event is SignUpLastNameChanged) {
      emit(state.copyWith(lastName: event.lastName));
    }
    //form submitted
    else if (event is SignUpSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        bool issuccessful = await authRepo.register(
          state.email,
          state.passwordSecond,
        );
        if (issuccessful) {
          await HiveStorage.storeUser(User(
            state.email,
            state.username,
            state.firstName,
            state.lastName,
          )
          );
          emit(state.copyWith(formStatus: SubmissionSuccess()));
        } else {
          emit(state.copyWith(
              formStatus: SubmissionFailed(
                  runTimeState.get<AppRunTimeStatus>().getExceptionMessage())));
        }
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
      }
    }
  }
}
