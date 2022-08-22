import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled/data/models/user_model.dart';
import 'package:untitled/presentation/Pages/Authentication/login.dart';
import 'package:untitled/presentation/Pages/Authentication/signup.dart';
import 'package:untitled/presentation/blocs/authentication/auth_bloc.dart';
import 'domain/entities/user.dart' as user_ent;
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
    return StreamProvider<user_ent.User>.value(
      initialData:
          UserModel.fromFirebaseUser(FirebaseAuth.instance.currentUser),
      value: Stream<user_ent.User>.value(
        UserModel.fromFirebaseUser(FirebaseAuth.instance.currentUser),
      ),
      child: Wraper(
          authBloc: authBloc,
          tecEmailLogIn: tecEmailLogIn,
          tecPassLogIn: tecPassLogIn,
          tecEmailSignUp: tecEmailSignUp,
          tecPassSignUp: tecPassSignUp),
    );
  }
}

class Wraper extends StatelessWidget {
  const Wraper({
    Key? key,
    required this.authBloc,
    required this.tecEmailLogIn,
    required this.tecPassLogIn,
    required this.tecEmailSignUp,
    required this.tecPassSignUp,
  }) : super(key: key);

  final AuthBloc authBloc;
  final TextEditingController tecEmailLogIn;
  final TextEditingController tecPassLogIn;
  final TextEditingController tecEmailSignUp;
  final TextEditingController tecPassSignUp;

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
        home: BlocBuilderWidget(
            tecEmailLogIn: tecEmailLogIn,
            tecPassLogIn: tecPassLogIn,
            tecEmailSignUp: tecEmailSignUp,
            tecPassSignUp: tecPassSignUp),
      ),
    );
  }
}

class BlocBuilderWidget extends StatelessWidget {
  const BlocBuilderWidget({
    Key? key,
    required this.tecEmailLogIn,
    required this.tecPassLogIn,
    required this.tecEmailSignUp,
    required this.tecPassSignUp,
  }) : super(key: key);

  final TextEditingController tecEmailLogIn;
  final TextEditingController tecPassLogIn;
  final TextEditingController tecEmailSignUp;
  final TextEditingController tecPassSignUp;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
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
          tecEmailSignUp.text = '';
          tecPassSignUp.text = '';
          return SignUp(
              tecEmailSignUp: tecEmailSignUp,
              tecPassSignUp: tecPassSignUp,
              tecEmailLogIn: tecEmailLogIn,
              tecPassLogIn: tecPassLogIn,
              popup: true,
              popupText: '',
              popupActions: const [
                'Done',
              ],
              popupOnPressActions: [
                (){},
              ],
          );
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
    );
  }
}
