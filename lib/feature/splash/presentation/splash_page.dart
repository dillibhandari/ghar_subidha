import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_subidha/core/common_widgets/custom_image_view.dart';
import 'package:ghar_subidha/core/constants/image_constants.dart';
import 'package:ghar_subidha/core/navigation/navigation.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/dimens.dart';
import 'package:ghar_subidha/core/utils/utils.dart';
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
    Future.delayed(const Duration(seconds: 3)).then((value) {
      context.read<SplashBloc>().add(InitializeSplash());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is GoLogin) {
          Navigation.replace(context, const LoginPageView());
        } else if (state is GoWalkThrough) {
          Navigation.replace(context, const WalkThrough());
        }
      },
      builder: (context, state) {
        return const SplashBodyView();
      },
    );
  }
}

class SplashBodyView extends StatelessWidget {
  const SplashBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Center(
        child: CustomImageView(
          imagePath: ImageConstants().png.logo,
          height: sizeX200 * Utils.getScalingFactor(context),
          width: sizeX300 * Utils.getScalingFactor(context),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
