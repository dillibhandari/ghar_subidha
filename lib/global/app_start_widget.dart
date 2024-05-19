import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/feature/booking/presentation/bloc/add_dates_cubit/add_dates_cubit.dart';
import 'package:ghar_subidha/feature/booking/presentation/bloc/booking_cubbit/booking_cubit.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/bloc/permission_bloc/permission_bloc.dart';
import 'package:ghar_subidha/feature/splash/presentation/splash_bloc/splash_bloc.dart';
import 'package:ghar_subidha/global/dependency_injection.dart' as di;

import '../feature/oboarding/presentation/bloc/walkthrough_cubit.dart';
import '../feature/splash/presentation/splash_page.dart';

class AppStartWidget extends StatefulWidget {
  const AppStartWidget({super.key});

  @override
  State<AppStartWidget> createState() => _AppStartWidgetState();
}

class _AppStartWidgetState extends State<AppStartWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WalkthroughCubit>(
            create: (_) => di.sl<WalkthroughCubit>()),
        BlocProvider<SplashBloc>(create: (_) => di.sl<SplashBloc>()),
        BlocProvider<PermissionBloc>(create: (_) => di.sl<PermissionBloc>()),
        BlocProvider<AddDatesCubit>(create: (_) => di.sl<AddDatesCubit>()),
        BlocProvider<BookingCubit>(create: (_) => di.sl<BookingCubit>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: GharSubidhaTheme.lightTheme(context),
        darkTheme: GharSubidhaTheme.darkTheme(context),
        themeMode: ThemeMode.light,
        home: const SplashPageView(),
      ),
    );
  }
}
