import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core
import '../localStorage/local_storage_service.dart';

// Auth
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user.dart';
import '../../features/auth/domain/usecases/initialize_auth.dart';
import '../../features/auth/domain/usecases/sign_in_with_google.dart';
import '../../features/auth/domain/usecases/sign_out.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

// Home
import '../../features/home/data/datasources/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/upload_photo.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';

// User Actions
import '../../features/user_actions/data/datasources/user_actions_remote_data_source.dart';
import '../../features/user_actions/data/repositories/user_actions_repository_impl.dart';
import '../../features/user_actions/domain/repositories/user_actions_repository.dart';
import '../../features/user_actions/domain/usecases/delete_account_usecase.dart';
import '../../features/user_actions/presentation/bloc/user_actions_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory(
    () => AuthBloc(
      signInWithGoogle: sl(),
      signOut: sl(),
      getCurrentUser: sl(),
      initializeAuth: sl(),
      authRepository: sl(),
    ),
  );
  sl.registerFactory(() => HomeBloc(uploadPhoto: sl()));
  sl.registerFactory(() => UserActionsBloc(deleteAccountUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => InitializeAuth(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => UploadPhoto(sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  sl.registerLazySingleton<UserActionsRepository>(
    () => UserActionsRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<UserActionsRemoteDataSource>(
    () => UserActionsRemoteDataSourceImpl(sl()),
  );

  // Core - Local Storage
  sl.registerLazySingleton<LocalStorageService>(
    () => LocalStorageServiceImpl(sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => GoogleSignIn.instance);
}
