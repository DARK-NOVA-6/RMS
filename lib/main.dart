import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presentation/Pages/Authentication/login.dart';
import 'package:untitled/presentation/Pages/Authentication/signup.dart';
import 'package:untitled/presentation/blocs/authentication/auth_bloc.dart';

import 'data/datasources/remote/firebase_authentication.dart';
import 'data/repositories/authentication_repo.dart';
import 'domain/usecases/authentication/log_out.dart';
import 'domain/usecases/authentication/sign_in_email_password.dart';
import 'domain/usecases/authentication/sign_up_email_password.dart';
import 'presentation/pages/authentication/authenticate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late final AuthenticationUsingTwoSteps authenticationUsingTwoSteps;
  late final AuthBloc authBloc;
  final TextEditingController tecEmailSignUp = TextEditingController();
  final tecPassSignUp = TextEditingController();
  final tecEmailLogIn = TextEditingController();
  final tecPassLogIn = TextEditingController();

  MyApp({Key? key}) : super(key: key) {
    authenticationUsingTwoSteps = AuthenticationUsingTwoSteps(
      authenticationRemote: FirebaseAuthentication(
        firebaseAuth: FirebaseAuth.instance,
      ),
    );

    authBloc = AuthBloc(
      signUpEmailPassword: SignUpEmailPassword(authenticationUsingTwoSteps),
      signInEmailAndPassword:
          SignInEmailAndPassword(authenticationUsingTwoSteps),
      logOut: LogOut(authenticationUsingTwoSteps),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => authBloc,
        ),
      ],
      child: MaterialApp(
        title: 'RMS Demo pla....',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return const Authenticate();
            } else if (state is SigningInState) {
              return LogIn(
                tecEmailLogIn: tecEmailLogIn,
                tecPassLogIn: tecPassLogIn,
                tecEmailSignUp: tecEmailSignUp,
                tecPassSignUp: tecPassSignUp,
              );
            } else if (state is SignedInState) {
              return const Authenticate();
            } else if (state is SignInErrorState) {
              return const Authenticate();
            } else if (state is SigningUpState) {
              return SignUp(
                tecEmailLogIn: tecEmailLogIn,
                tecPassLogIn: tecPassLogIn,
                tecEmailSignUp: tecEmailSignUp,
                tecPassSignUp: tecPassSignUp,
              );
            } else if (state is SignedUpState) {
              return const Authenticate();
            } else if (state is SignUpErrorState) {
              return const Authenticate();
            } else {
              return const Text('unexpected state!');
            }
          },
        ),
      ),
    );
  }
}
