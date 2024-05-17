import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_subidha/feature/auth/presentation/view/login_page_view.dart';
 import '../../oboarding/presentation/view/walk_through.dart';
import 'package:ghar_subidha/feature/splash/presentation/splash_bloc/splash_bloc.dart';
 
class SplashPageView extends StatefulWidget {
  const SplashPageView({super.key});

  @override
  State<SplashPageView> createState() => _SplashPageViewState();
}

class _SplashPageViewState extends State<SplashPageView> {
  @override
  void initState() {
    context.read<SplashBloc>().add(InitializeSplash());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, bool>(
      builder: (context, state) {
        if (state) {
          return const LoginPageView();
        } else {
          return const WalkThrough();
        }
      },
    );
  }
}
