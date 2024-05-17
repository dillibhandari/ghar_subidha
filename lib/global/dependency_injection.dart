import 'package:get_it/get_it.dart';
import 'package:ghar_subidha/core/database/database_helper.dart';
import 'package:ghar_subidha/feature/auth/presentation/bloc/sign_in_bloc/signin_bloc.dart';
import 'package:ghar_subidha/feature/auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/bloc/permission_bloc/permission_bloc.dart';
import 'package:ghar_subidha/feature/splash/presentation/splash_bloc/splash_bloc.dart';
import '../core/helper/preferences/preferences.dart';
import 'package:ghar_subidha/feature/oboarding/domain/repositories/walkthrough_repository.dart';
import 'package:ghar_subidha/feature/oboarding/domain/usecase/walkthrough_usecase.dart';
import 'package:ghar_subidha/feature/oboarding/presentation/bloc/walkthrough_cubit.dart';
import '../feature/oboarding/data/datasources/walkthrough_local_data_sources.dart';
import '../feature/oboarding/data/repositories/walkthrough_repository_impl.dart';

GetIt sl = GetIt.instance;

Future<void> initialize() async {
  // blocs
  sl.registerFactory(() => WalkthroughCubit(sl()));
  sl.registerFactory(() => SplashBloc(sl()));
sl.registerFactory(() => SigninBloc());
  sl.registerFactory(() => SignUpBloc());
  sl.registerFactory(()=>PermissionBloc());

  // usecase

  sl.registerLazySingleton(() => WalkthroughUseCase(sl()));
  // sl.registerLazySingleton(() => null)

  //repository
  sl.registerLazySingleton<WalkthroughRepository>(
      () => WalkthroughRepositoryImpl(sl()));

  /// Externals
  final preferences = Preferences.instance;
  sl.registerSingleton<Preferences>(preferences);

  //Data source
  //local data source
  sl.registerLazySingleton<WalkthroughLocalDataSources>(
      () => WalkthroughLocalDataSourcesImpl(preferences));

  // DatabaseHelper
  sl.registerLazySingleton(() => DbHelper());
}
