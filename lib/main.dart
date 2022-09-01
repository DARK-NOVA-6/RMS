import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/data/models/user_model.dart';
import 'package:untitled/presentation/blocs/authentication/auth_bloc.dart';
import 'package:untitled/provider/update_action_bar_actions_notification.dart';
import 'domain/entities/user.dart' as user_ent;
import 'data/datasources/remote/firebase_authentication.dart';
import 'data/repositories/authentication_repo.dart';
import 'domain/usecases/authentication/get_connected_user.dart';
import 'domain/usecases/authentication/log_out.dart';
import 'domain/usecases/authentication/sign_in_email_password.dart';
import 'domain/usecases/authentication/sign_up_email_password.dart';
import 'presentation/wrapper.dart';
import 'presentation/controllers/controllers.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signOut();
  init();
  // runApp(const MyApp2());
  runApp(
    ChangeNotifierProvider(
      create: (_)=>UpdateActionBarActions(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  late final AuthenticationUsingTwoSteps authenticationUsingTwoSteps;
  late final AuthBloc authBloc;
  late final GetConnectedUser getConnectedUser;
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
      initialState:
          UserModel.fromFirebaseUser(FirebaseAuth.instance.currentUser).id == ''
              ? AuthInitial()
              : SignedInState(
                  user: UserModel.fromFirebaseUser(
                      FirebaseAuth.instance.currentUser)),
    );

    getConnectedUser = GetConnectedUser(
      AuthenticationUsingTwoSteps(
        authenticationRemote: FirebaseAuthentication(
          firebaseAuth: FirebaseAuth.instance,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<user_ent.User>.value(
      initialData:
          UserModel.fromFirebaseUser(FirebaseAuth.instance.currentUser),
      value: getConnectedUser.connectedUser,
      child: Wrapper(
        authBloc: authBloc,
        controllers: controllers,
      ),
    );
  }
}
