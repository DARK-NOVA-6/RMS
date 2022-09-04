import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_validator/string_validator.dart';

import '../../../core/errors/failures/authentication_failures.dart';
import '../../../domain/usecases/authentication/log_out.dart';
import '../../../domain/usecases/authentication/sign_in_email_password.dart';
import '../../../domain/usecases/authentication/sign_up_email_password.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpEmailPassword signUpEmailPassword;
  final SignInEmailAndPassword signInEmailAndPassword;
  final LogOut logOut;

  AuthBloc({
    required this.signUpEmailPassword,
    required this.signInEmailAndPassword,
    required this.logOut,
    required AuthState initialState,
  }) : super(initialState) {
    on<GetSignUpEvent>((event, emit) async {
      emit(Loading());
      await Future.delayed(const Duration(microseconds: 200));
      emit(SigningUpState());
    });
    on<GetSignInEvent>((event, emit) async {
      emit(Loading());
      await Future.delayed(const Duration(microseconds: 200));
      emit(SigningInState());
    });
    on<SignUpEvent>(signUpEventHandle);
    on<LoginEvent>(loginEventHandle);
    on<LogOutEvent>((event, emit) async {
      await logOut();
      emit(AuthInitial());
    });
  }

  void signUpEventHandle(SignUpEvent event, Emitter emit) async {
    emit(Loading());
    await Future.delayed(const Duration(microseconds: 200));
    if (event.confPassword != event.password) {
      emit(const SignUpErrorState(message: 'pass dif from conf pass'));
    } else if (!isEmail(event.email)) {
      emit(SignUpErrorState(message: const InvalidEmail().message));
    } else {
      final result = await signUpEmailPassword(
          email: event.email, password: event.password);
      result.fold(
        (failure) => emit(SignUpErrorState(message: failure.message)),
        (user) => emit(const SignedUpState()),
      );
    }
  }

  void loginEventHandle(LoginEvent event, Emitter emit) async {
    if (!isEmail(event.email)) {
      emit(SignInErrorState(message: const InvalidEmail().message));
    } else {
      final result = await signInEmailAndPassword(
          email: event.email, password: event.password);
      result.fold(
        (failure) => emit(SignInErrorState(message: failure.message)),
        (user) => emit(const SignedInState()),
      );
    }
  }
}
