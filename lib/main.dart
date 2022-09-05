import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/blocs/authentication/auth_bloc.dart';
import 'package:untitled/provider/update_action_bar_actions_notification.dart';

import 'data/repositories/authentication_repo.dart';
import 'domain/usecases/authentication/get_connected_user.dart';
import 'domain/usecases/authentication/log_out.dart';
import 'domain/usecases/authentication/sign_in_email_password.dart';
import 'domain/usecases/authentication/sign_up_email_password.dart';
import 'injection_container.dart';
import 'presentation/controllers/controllers.dart';
import 'presentation/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  init();
  // globalUserInfo =
  //     (await getProfileUser(userId: 'KNvVSQq2xSUaxUNsEbHCu5VvHWv2'))!;
  // runApp(const MyApp2());

  runApp(
    Phoenix(
      child: ChangeNotifierProvider(
        create: (_) => UpdateActionBarActions(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  late final AuthenticationUsingTwoSteps authenticationUsingTwoSteps;
  late final AuthBloc authBloc;
  late final GetConnectedUser getConnectedUser;
  final Controllers controllers = Controllers();

  MyApp({Key? key}) : super(key: key) {

    authenticationUsingTwoSteps =
        AuthenticationUsingTwoSteps(authenticationRemote: sl());

    authBloc = AuthBloc(
      signUpEmailPassword: SignUpEmailPassword(authenticationUsingTwoSteps),
      signInEmailAndPassword:
          SignInEmailAndPassword(authenticationUsingTwoSteps),
      logOut: LogOut(authenticationUsingTwoSteps),
      initialState: FirebaseAuth.instance.currentUser == null
          ? AuthInitial()
          : const SignedInState(),
    );

    getConnectedUser = GetConnectedUser();
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      authBloc: authBloc,
      controllers: controllers,
    );
  }
}
