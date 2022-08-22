import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/Pages/Authentication/login.dart';
import 'package:untitled/presentation/Pages/Authentication/signup.dart';
import 'package:untitled/presentation/blocs/authentication/auth_bloc.dart';

import 'data/datasources/remote/firebase_authentication.dart';
import 'data/repositories/authentication_repo.dart';
import 'domain/usecases/authentication/log_out.dart';
import 'domain/usecases/authentication/sign_in_email_password.dart';
import 'domain/usecases/authentication/sign_up_email_password.dart';
import 'presentation/pages/authentication/authenticate.dart';
import 'domain/entities/user.dart' as user_ent;
import 'data/models/user_model.dart';
import 'presentation/pages/home/home.dart';

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
  late user_ent.User user;

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

    user = UserModel.fromFirebaseUser(FirebaseAuth.instance.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<user_ent.User>.value(
      value: Stream<user_ent.User>.value(
        UserModel.fromFirebaseUser(FirebaseAuth.instance.currentUser),
      ),
      initialData: user,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => authBloc,
          ),
        ],
        child: Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);
  final TextEditingController tecEmailSignUp = TextEditingController();
  final tecPassSignUp = TextEditingController();
  final tecEmailLogIn = TextEditingController();
  final tecPassLogIn = TextEditingController();


  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        BlocProvider.of<AuthBloc>(context).add(Get);
      }
    });


    return (Provider.of<user_ent.User>(context)).id == ''
        ? temp(context)
        : Home();
  }

  Widget temp(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
