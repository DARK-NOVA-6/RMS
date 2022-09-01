import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'data/datasources/remote/evaluator_api.dart';
import 'data/datasources/remote/firebase_authentication.dart';
import 'data/repositories/authentication_repo.dart';
import 'data/repositories/job/recommended_repo_imp.dart';
import 'data/repositories/job/unavailable_repo_imp.dart';
import 'data/repositories/user_info_repo_imp.dart';
import 'domain/repositories/authentication_repo.dart';
import 'domain/repositories/job/recommended_repo.dart';
import 'domain/repositories/job/unavailable_repo.dart';
import 'domain/repositories/user_info_repo.dart';
import 'domain/usecases/authentication/get_connected_user.dart';
import 'domain/usecases/authentication/log_out.dart';
import 'domain/usecases/authentication/sign_in_email_password.dart';
import 'domain/usecases/authentication/sign_up_email_password.dart';
import 'domain/usecases/job/recommended/fetch_more.dart';
import 'domain/usecases/job/recommended/get_detailed.dart';
import 'domain/usecases/job/unavailable/fetch_more.dart';
import 'domain/usecases/job/unavailable/get_detailed.dart';
import 'domain/usecases/user/get_profile_user.dart';
import 'domain/usecases/user/update_profile_user.dart';

final sl = GetIt.instance;

void init() {
  initData();
  initUseCases();
}

void initData() {
  // datasources
  sl.registerSingleton(FirebaseFirestore.instance);
  sl.registerLazySingleton<EvaluatorApi>(() => EvaluatorApiImp());
  sl.registerLazySingleton<AuthenticationRemote>(
    () => FirebaseAuthentication(firebaseAuth: FirebaseAuth.instance),
  );
  // repositories
  sl.registerLazySingleton<AuthenticationRepo>(
    () => AuthenticationUsingTwoSteps(authenticationRemote: sl()),
  );
  sl.registerLazySingleton<UserInfoRepo>(
    () => UserInfoRepoImp(
      firebaseFirestore: sl(),
      authenticationRepo: sl(),
    ),
  );
  sl.registerFactory<RecommendedRepo>(
    () => RecommendedRepoImp(
      firebaseFirestore: sl(),
      evaluatorApi: sl(),
      userId: 'KNvVSQq2xSUaxUNsEbHCu5VvHWv2',
      // userId: GetConnectedUser(sl()).userId!,
    ),
  );
  sl.registerFactory<UnavailableRepo>(
    () => UnavailableRepoImp(
      firebaseFirestore: sl(),
      evaluatorApi: sl(),
      userId: 'KNvVSQq2xSUaxUNsEbHCu5VvHWv2',
      // userId: GetConnectedUser(sl()).userId!,
    ),
  );
}

void initUseCases() {
  // authentication
  sl.registerLazySingleton(() => GetConnectedUser(sl()));
  sl.registerLazySingleton(() => LogOut(sl()));
  sl.registerLazySingleton(() => SignInEmailAndPassword(sl()));
  sl.registerLazySingleton(() => SignUpEmailPassword(sl()));

  // job - recommended
  sl.registerSingleton(FetchMoreRecommended(sl()));
  sl.registerSingleton(GetDetailedRecommended(sl()));
  // job - unavailable
  sl.registerSingleton(FetchMoreUnavailable(sl()));
  sl.registerSingleton(GetDetailedUnavailable(sl()));

  // user
  sl.registerSingleton(GetProfileUser(userInfoRepo: sl()));
  sl.registerSingleton(UpdateProfileUser(userInfoRepo: sl()));
}
