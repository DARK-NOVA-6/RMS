import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/data/repositories/job/applied_repo_imp.dart';
import 'package:untitled/domain/repositories/job/applied_repo.dart';
import 'package:untitled/domain/usecases/job/applied/fetch_more.dart';
import 'data/datasources/remote/autocomplete_substring_api.dart';
import 'data/datasources/remote/evaluator_api.dart';
import 'data/datasources/remote/firebase_authentication.dart';
import 'data/repositories/authentication_repo.dart';
import 'data/repositories/job/recommended_repo_imp.dart';
import 'data/repositories/job/unavailable_repo_imp.dart';
import 'data/repositories/keywords/keywords_degree_edu_repo_substring.dart';
import 'data/repositories/keywords/keywords_field_edu_repo_substring.dart';
import 'data/repositories/keywords/keywords_job_titles_repo_substring.dart';
import 'data/repositories/keywords/keywords_languages_repo_substring.dart';
import 'data/repositories/keywords/keywords_skills_repo_substring.dart';
import 'data/repositories/keywords/keywords_universities_repo_substring.dart';
import 'data/repositories/user_info_repo_imp.dart';
import 'domain/repositories/authentication_repo.dart';
import 'domain/repositories/job/recommended_repo.dart';
import 'domain/repositories/job/unavailable_repo.dart';
import 'domain/repositories/keywords/keywords_degree_edu_repo.dart';
import 'domain/repositories/keywords/keywords_field_edu_repo.dart';
import 'domain/repositories/keywords/keywords_job_titles_repo.dart';
import 'domain/repositories/keywords/keywords_languages_repo.dart';
import 'domain/repositories/keywords/keywords_skills_repo.dart';
import 'domain/repositories/keywords/keywords_universities_repo.dart';
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
import 'domain/entities/user/user_info.dart' as user_info;

final sl = GetIt.instance;

user_info.UserInfo? globalUserInfo;

void init() {
  initData();
  initUseCases();
}

void initData() {
  // datasources
  sl.registerSingleton(FirebaseFirestore.instance);
  sl.registerLazySingleton<EvaluatorApi>(() => EvaluatorApiImp());
  sl.registerLazySingleton<AuthenticationRemote>(
    () => FirebaseAuthentication(
      firebaseAuth: FirebaseAuth.instance,
      userInfoRepo: UserInfoRepoImp(
        firebaseFirestore: sl(),
      ),
    ),
  );
  sl.registerLazySingleton<AutocompleteSubstringApi>(
    () => AutocompleteSubstringApiImp(),
  );
  // repositories
  sl.registerLazySingleton<AuthenticationRepo>(
    () => AuthenticationUsingTwoSteps(authenticationRemote: sl()),
  );
  sl.registerLazySingleton<UserInfoRepo>(
    () => UserInfoRepoImp(
      firebaseFirestore: sl(),
    ),
  );
  sl.registerLazySingleton<RecommendedRepo>(
    () => RecommendedRepoImp(
      firebaseFirestore: sl(),
      evaluatorApi: sl(),
      userId: 'KNvVSQq2xSUaxUNsEbHCu5VvHWv2',
      // userId: GetConnectedUser(sl()).userId!,
    ),
  );
  sl.registerLazySingleton<UnavailableRepo>(
    () => UnavailableRepoImp(
      firebaseFirestore: sl(),
      evaluatorApi: sl(),
      userId: 'KNvVSQq2xSUaxUNsEbHCu5VvHWv2',
      // userId: GetConnectedUser(sl()).userId!,
    ),
  );
  sl.registerLazySingleton<AppliedRepo>(
    () => AppliedRepoImp(
      firebaseFirestore: sl(),
      authenticationRepo: sl(),
    ),
  );
  sl.registerFactory<KeywordsSkillsRepo>(
    () => KeywordsSkillsRepoSubstring(),
  );
  sl.registerFactory<KeywordsLanguagesRepo>(
    () => KeywordsLanguagesRepoSubstring(),
  );
  sl.registerFactory<KeywordsFieldEduRepo>(
    () => KeywordsFieldEduRepoSubstring(),
  );
  sl.registerFactory<KeywordsDegreeEduRepo>(
    () => KeywordsDegreeEduRepoSubstring(),
  );
  sl.registerFactory<KeywordsJobTitlesRepo>(
    () => KeywordsJobTitlesRepoSubstring(),
  );
  sl.registerFactory<KeywordsUniversitiesRepo>(
    () => KeywordsUniversitiesRepoSubstring(),
  );
}

void initUseCases() {
  // authentication
  sl.registerLazySingleton(() => GetConnectedUser(sl()));
  sl.registerLazySingleton(() => LogOut(sl()));
  sl.registerLazySingleton(() => SignInEmailAndPassword(sl()));
  sl.registerLazySingleton(() => SignUpEmailPassword(sl()));

  // job - recommended
  sl.registerSingleton(FetchMoreRecommended());
  sl.registerSingleton(GetDetailedRecommended());
  // job - unavailable
  sl.registerSingleton(FetchMoreUnavailable());
  sl.registerSingleton(GetDetailedUnavailable());
  // job - unavailable
  sl.registerSingleton(FetchMoreApplied());

  // user
  sl.registerSingleton(GetProfileUser());
  sl.registerSingleton(UpdateProfileUser());
}
