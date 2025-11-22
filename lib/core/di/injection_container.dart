import 'package:antifilter_app/features/favorites/data/datasources/favorite_remote_data_source.dart';
import 'package:antifilter_app/features/favorites/data/repositories/favorite_repository_impl.dart';
import 'package:antifilter_app/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core
import '../../features/favorites/domain/usecases/get_all_photos.dart';
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
import '../../features/home/domain/usecases/get_recent_photos.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';

// User Actions
import '../../features/user_actions/data/datasources/user_actions_remote_data_source.dart';
import '../../features/user_actions/data/repositories/user_actions_repository_impl.dart';
import '../../features/user_actions/domain/repositories/user_actions_repository.dart';
import '../../features/user_actions/domain/usecases/delete_account_usecase.dart';
import '../../features/user_actions/presentation/bloc/user_actions_bloc.dart';

// Photo Editor
import '../../features/photo_editor/data/datasources/photo_editor_remote_data_source.dart';
import '../../features/photo_editor/data/repositories/photo_editor_repository_impl.dart';
import '../../features/photo_editor/domain/repositories/photo_editor_repository.dart';
import '../../features/photo_editor/domain/usecases/upload_photo_usecase.dart';
import '../../features/photo_editor/domain/usecases/save_to_favorites_usecase.dart';
import '../../features/photo_editor/presentation/bloc/photo_editor_bloc.dart';

// History
import '../../features/history/data/datasources/history_remote_data_source.dart';
import '../../features/history/data/repositories/history_repository_impl.dart';
import '../../features/history/domain/repositories/history_repository.dart';
import '../../features/history/domain/usecases/get_all_photos.dart';
import '../../features/history/presentation/bloc/history_bloc.dart';

// Favorite
import '../../features/favorites/presentation/bloc/favorite_bloc.dart';

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
  sl.registerFactory(() => HomeBloc(getRecentPhotos: sl()));
  sl.registerFactory(() => UserActionsBloc(deleteAccountUseCase: sl()));
  sl.registerFactory(
    () =>
        PhotoEditorBloc(uploadPhotoUseCase: sl(), saveToFavoritesUseCase: sl()),
  );
  sl.registerFactory(() => HistoryBloc(getAllPhotos: sl()));
  sl.registerFactory(() => FavoriteBloc(getAllPhotos: sl()));

  // Use cases
  sl.registerLazySingleton(() => InitializeAuth(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => GetRecentPhotos(sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));
  sl.registerLazySingleton(() => UploadPhotoUseCase(sl()));
  sl.registerLazySingleton(() => SaveToFavoritesUseCase(sl()));
  sl.registerLazySingleton(() => GetAllPhotos(sl()));
  sl.registerLazySingleton(() => GetAllPhotosFav(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  sl.registerLazySingleton<UserActionsRepository>(
    () => UserActionsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<PhotoEditorRepository>(
    () => PhotoEditorRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(sl()),
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
  sl.registerLazySingleton<PhotoEditorRemoteDataSource>(
    () => PhotoEditorRemoteDataSourceImpl(
      firestore: sl(),
      storage: sl(),
      auth: sl(),
    ),
  );
  sl.registerLazySingleton<HistoryRemoteDataSource>(
    () => HistoryRemoteDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<FavoriteRemoteDataSource>(
    () => FavoriteRemoteDataSourceImpl(sl(), sl()),
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
