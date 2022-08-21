import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_validator/string_validator.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/authentication/log_out.dart';
import '../../../domain/usecases/authentication/sign_in_email_password.dart';
import '../../../domain/usecases/authentication/sign_up_email_password.dart';
import '../../../domain/usecases/authentication/submit_conf_code.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpEmailPassword signUpEmailPassword;
  final SignInEmailAndPassword signInEmailAndPassword;
  final SubmitConfCode submitConfCode;
  final LogOut logOut;

  AuthBloc({
    required this.signUpEmailPassword,
    required this.signInEmailAndPassword,
    required this.submitConfCode,
    required this.logOut,
  }) : super(AuthInitial()) {
    on<GetSignUpEvent>((event, emit) => emit(SigningUpState()));
    on<GetSignInEvent>((event, emit) => emit(SigningInState()));
    on<GetConfCodeEvent>(getConfCodeEventHandle);
    on<LoginEvent>(loginEventHandle);
    on<SubmitConfCodeEvent>(submitConfCodeEventHandle);
  }

  void getConfCodeEventHandle(GetConfCodeEvent event, Emitter emit) async {
    if (event.confPassword != event.password) {
      emit(const SignUpErrorState(message: 'pass dif from conf pass'));
    } else if (!isEmail(event.email)) {
      emit(const SignUpErrorState(message: 'invalid email'));
    } else {
      final result = await signUpEmailPassword(
          email: event.email, password: event.password);
      result.fold(
        (failure) =>
            emit(const SignUpErrorState(message: 'server or token email')),
        (any) => emit(PendingConfCodeState()),
      );
    }
  }

  void loginEventHandle(LoginEvent event, Emitter emit) async {
    if (!isEmail(event.email)) {
      emit(const SignInErrorState(message: 'invalid email'));
    } else {
      final result = await signInEmailAndPassword(
          email: event.email, password: event.password);
      result.fold(
        (failure) =>
            emit(const SignInErrorState(message: 'server or invalid input')),
        (user) => emit(SignedInState(user: user)),
      );
    }
  }

  void submitConfCodeEventHandle(
      SubmitConfCodeEvent event, Emitter emit) async {
    final result = await submitConfCode(code: event.code);
    result.fold(
      (failure) =>
          emit(const SignUpErrorState(message: 'server or invalid code')),
      (user) => emit(SignedUpState(user: user)),
    );
  }
}
