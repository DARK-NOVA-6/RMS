import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/data/models/user_model.dart';
import 'package:untitled/presentation/blocs/authentication/auth_bloc.dart';
import 'domain/entities/user.dart' as user_ent;
import 'data/datasources/remote/firebase_authentication.dart';
import 'data/repositories/authentication_repo.dart';
import 'domain/usecases/authentication/log_out.dart';
import 'domain/usecases/authentication/sign_in_email_password.dart';
import 'domain/usecases/authentication/sign_up_email_password.dart';
import 'presentation/wrapper.dart';
import 'presentation/controllers/controllers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  late final AuthenticationUsingTwoSteps authenticationUsingTwoSteps;
  late final AuthBloc authBloc;
  final Controllers controllers = Controllers();

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
      child: Wrapper(
          authBloc: authBloc,
          controllers: controllers,
      ),
    );
  }
}

