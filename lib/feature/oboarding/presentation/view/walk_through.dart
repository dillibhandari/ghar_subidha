import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_subidha/core/constants/image_constants.dart';
import 'package:ghar_subidha/feature/auth/presentation/view/login_page_view.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/view/dashboard_page_view.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/size_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_image_view.dart';
import '../../../../core/navigation/navigation.dart';
import '../../../../core/utils/dimens.dart';
import '../../../../core/utils/utils.dart';
import '../bloc/walkthrough_cubit.dart';

class WalkThrough extends StatefulWidget {
  const WalkThrough({super.key});

  @override
  State<WalkThrough> createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  final PageController pageController = PageController();
  late WalkthroughCubit walkthroughCubit;
  int initialIndex = 0;

  @override
  void initState() {
    walkthroughCubit = context.read<WalkthroughCubit>();
    walkthroughCubit.setIndex(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: Utils().getPadding(
                right: paddingX20 * Utils.getScalingFactor(context),
                top: paddingX20 * Utils.getScalingFactor(context)),
            child: InkWell(
              onTap: () {
                context.read<WalkthroughCubit>().setWalkthroughSeen();
                Navigation.push(context, const DashboardPageView());
              },
              child: Text(
                "skip",
                style: GharSubidhaTheme.getTextTheme(context)
                    .bodyTextSmall
                    ?.copyWith(fontSize: fontBodyTextLarge),
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              itemCount: walkthroughCubit.sliderItems.length,
              controller: pageController,
              onPageChanged: (currentIndex) =>
                  walkthroughCubit.setIndex(currentIndex),
              itemBuilder: (context, index) {
                return viewSection(index, context);
              },
            ),
            BlocBuilder<WalkthroughCubit, WalkthroughState>(
              builder: (context, state) {
                return state is! WalkthroughSlider
                    ? Container()
                    : bottomSection(state, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView viewSection(int index, BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: Utils()
                .getVerticalSize(sizeX380 * Utils.getScalingFactor(context)),
            padding: Utils()
                .getMargin(all: paddingX20 * Utils.getScalingFactor(context)),
            width: double.infinity,
            child: Center(
              child: CustomImageView(
                imagePath: walkthroughCubit.sliderItems[index]['image'],
              ),
            ),
          ),
          SizedBox(height: Utils().getVerticalSize(sizeX16)),
          headingAndMessageWidget(index, context)
        ],
      ),
    );
  }

  Positioned bottomSection(WalkthroughSlider state, BuildContext context) {
    return Positioned(
      bottom: sizeX20 * Utils.getScalingFactor(context),
      right: sizeX20 * Utils.getScalingFactor(context),
      left: sizeX20 * Utils.getScalingFactor(context),
      child: Column(
        children: [
          swipeIndicator(state),
          SizedBox(height: Utils().getVerticalSize(sizeX30)),
          _footerSection(state, context),
          SizedBox(height: Utils().getVerticalSize(sizeX20)),
        ],
      ),
    );
  }

  Padding headingAndMessageWidget(int index, BuildContext context) {
    return Padding(
      padding: Utils().getPadding(all: paddingX16),
      child: Column(
        children: [
          Text(
            walkthroughCubit.sliderItems[index]['title'] ?? "",
            style: GharSubidhaTheme.getTextTheme(context)
                .bodyTextSmall
                ?.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Utils().getVerticalSize(26.v)),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      walkthroughCubit.sliderItems[index]['des_title1'] ?? "",
                      style: GharSubidhaTheme.getTextTheme(context)
                          .headingXMedium
                          ?.copyWith(
                              color: AppColors.title1Color,
                              fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: sizeX10 * Utils.getScalingFactor(context)),
                    Text(
                      walkthroughCubit.sliderItems[index]['des_title2'] ?? "",
                      style: GharSubidhaTheme.getTextTheme(context)
                          .headingXMedium
                          ?.copyWith(
                              color: AppColors.secondaryColor,
                              fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Center swipeIndicator(WalkthroughSlider state) {
    return Center(
      child: SizedBox(
        height: sizeX8,
        child: AnimatedSmoothIndicator(
          activeIndex: state.index,
          count: walkthroughCubit.sliderItems.length,
          effect: ExpandingDotsEffect(
            spacing: sizeX6,
            activeDotColor: AppColors.secondaryColor,
            dotColor: AppColors.secondaryColor,
            dotHeight: sizeX8,
            strokeWidth: 1.5,
            dotWidth: sizeX10 * Utils.getScalingFactor(context),
          ),
        ),
      ),
    );
  }

  Widget getStartedBtn(WalkthroughSlider state, BuildContext context) {
    return CustomButton(
      width: state.index == walkthroughCubit.sliderItems.length - 1
          ? Utils()
              .getHorizontalSize(sizeX170 * Utils.getScalingFactor(context))
          : Utils()
              .getHorizontalSize(sizeX120 * Utils.getScalingFactor(context)),
      height:
          Utils().getHorizontalSize(sizeX55 * Utils.getScalingFactor(context)),
      buttonStyle: CustomButtonStyles.walkthrough,
      rightIcon: state.index == walkthroughCubit.sliderItems.length - 1
          ? Container(
              margin: Utils()
                  .getMargin(left: marginX10 * Utils.getScalingFactor(context)),
              child: const Icon(Icons.arrow_forward,
                  color: AppColors.primaryColor))
          : const SizedBox(),
      text: state.index == walkthroughCubit.sliderItems.length - 1
          ? "Get  Started"
          : 'Next',
      buttonTextStyle: GharSubidhaTheme.getTextTheme(context)
          .bodyTextLarge
          ?.copyWith(
              color: AppColors.primaryColor, fontWeight: FontWeight.w600),
      onPressed: () {
        if (state.index == walkthroughCubit.sliderItems.length - 1) {
          context.read<WalkthroughCubit>().setWalkthroughSeen();
          Navigation.replace(context, const LoginPageView());
        } else {
          pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
          );
        }
      },
    );
  }

  _footerSection(WalkthroughSlider state, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomImageView(
          imagePath: ImageConstants().png.logo,
          height: sizeX60 * Utils.getScalingFactor(context),
          width: sizeX100 * Utils.getScalingFactor(context),
          fit: BoxFit.fill,
        ),
        getStartedBtn(state, context),
      ],
    );
  }
}
