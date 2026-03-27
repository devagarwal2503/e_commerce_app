import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/common/app/provider/user_provider.dart';
import 'package:e_commerce_app/core/common/app/provider/local_provider.dart';
import 'package:e_commerce_app/core/services/razorpay_services.dart';
import 'package:e_commerce_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:e_commerce_app/src/authentication/data/datasources/authentication_remote_data_source_impl.dart';
import 'package:e_commerce_app/src/authentication/data/repository/authentication_repository_impl.dart';
import 'package:e_commerce_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:e_commerce_app/src/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:e_commerce_app/src/authentication/domain/usecases/sigh_up_usecase.dart';
import 'package:e_commerce_app/src/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:e_commerce_app/src/authentication/domain/usecases/update_user_usecase.dart';
import 'package:e_commerce_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:e_commerce_app/src/cart/data/datasources/product_details_datasource.dart';
import 'package:e_commerce_app/src/cart/data/repository/product_details_repo_impl.dart';
import 'package:e_commerce_app/src/cart/domain/repository/product_details_repo.dart';
import 'package:e_commerce_app/src/cart/domain/usecases/get_product_details_usecase.dart';
import 'package:e_commerce_app/src/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce_app/src/cart/presentation/bloc/product_details_bloc.dart';
import 'package:e_commerce_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:e_commerce_app/src/on_boarding/data/repository/on_boarding_repository_impl.dart';
import 'package:e_commerce_app/src/on_boarding/domain/repository/on_boarding_repository.dart';
import 'package:e_commerce_app/src/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:e_commerce_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer_usecase.dart';
import 'package:e_commerce_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  await _onBoardingInit();
  await _authenticationInit();
  await _getProductInit();

  // External
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => UserProvider());
  sl.registerLazySingleton(() => LocaleProvider(sl()));
  sl.registerLazySingleton<RazorpayService>(() => RazorpayService());
}

Future<void> _onBoardingInit() async {
  // Blocs / Cubits
  sl.registerFactory(
    () => OnBoardingCubit(
      cacheFirstTimerUsecase: sl(),
      checkingIfUserIsFirstTimerUsecase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => CacheFirstTimerUsecase(sl()));
  sl.registerLazySingleton(() => CheckIfUserIsFirstTimerUsecase(sl()));

  // Repositories
  sl.registerLazySingleton<OnBoardingRepository>(
    () => OnBoardingRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<OnBoardingLocalDataSource>(
    () => OnBoardingLocalDataSourceImpl(sl()),
  );
}

Future<void> _authenticationInit() async {
  // Blocs / Cubits
  sl.registerFactory(
    () => AuthenticationBloc(
      signInUsecase: sl(),
      signUpUsecase: sl(),
      forgotPasswordUsecase: sl(),
      updateUserUsecase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignInUsecase(sl()));
  sl.registerLazySingleton(() => SignUpUsecase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUsecase(sl()));
  sl.registerLazySingleton(() => UpdateUserUsecase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(
      authCLient: sl(),
      cloudStoreClient: sl(),
      dbClient: sl(),
    ),
  );
}

Future<void> _getProductInit() async {
  // Blocs / Cubits
  sl.registerFactory(() => ProductDetailsBloc(getProductDetailsUsecase: sl()));
  sl.registerFactory(() => CartBloc());

  // Use cases
  sl.registerLazySingleton(() => GetProductDetailsUsecase(sl()));

  // Repositories
  sl.registerLazySingleton<ProductDetailsRepo>(
    () => ProductDetailsRepoImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProductDetailsDatasource>(
    () => ProductDetailsDatasourceImpl(),
  );
}
