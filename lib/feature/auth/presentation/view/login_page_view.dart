import 'package:flutter/material.dart';
import 'package:ghar_subidha/core/common_widgets/custom_button.dart';
import 'package:ghar_subidha/core/common_widgets/custom_image_view.dart';
import 'package:ghar_subidha/core/common_widgets/custom_text_field.dart';
import 'package:ghar_subidha/core/common_widgets/top_snack_bar.dart';
import 'package:ghar_subidha/core/constants/image_constants.dart';
import 'package:ghar_subidha/core/navigation/navigation.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/dimens.dart';
import 'package:ghar_subidha/core/utils/utils.dart';
import 'package:ghar_subidha/feature/auth/presentation/view/register_page_view.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/view/dashboard_page_view.dart';

class LoginPageView extends StatelessWidget {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(elevation: 0),
      body: Padding(
        padding: Utils().getPadding(
          all: paddingX20 * Utils.getScalingFactor(context),
        ),
        child: const LoginBodyView(),
      ),
    );
  }
}

class LoginBodyView extends StatefulWidget {
  const LoginBodyView({super.key});

  @override
  State<LoginBodyView> createState() => _LoginBodyViewState();
}

class _LoginBodyViewState extends State<LoginBodyView> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  final TextEditingController _loginEmailTextEditingController =
      TextEditingController();

  final TextEditingController _loginPasswordTextEditingController =
      TextEditingController();
  static String emailAddress = "tanka@gmail.com";
  static String passwords = "tanka123";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: sizeX20 * Utils.getScalingFactor(context)),
          CustomImageView(
            imagePath: ImageConstants().png.logo,
            height: sizeX100 * Utils.getScalingFactor(context),
          ),
          SizedBox(height: sizeX40 * Utils.getScalingFactor(context)),
          Text(
            "Login",
            style: GharSubidhaTheme.getTextTheme(context).headingLarge,
          ),
          formWidget(context),
          forgotAndLoginWidget(context),
          SizedBox(height: sizeX20 * Utils.getScalingFactor(context)),
          _buildOrDivider(context),
          SizedBox(height: sizeX30 * Utils.getScalingFactor(context)),
          googleSignIn(context),
          SizedBox(height: sizeX30 * Utils.getScalingFactor(context)),
          signUpWidget(context)
        ],
      ),
    );
  }

  Row forgotAndLoginWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Spacer(),
        Expanded(
          flex: 2,
          child: Text(
            "Forgot Password ? ",
            style: GharSubidhaTheme.getTextTheme(context)
                .bodyTextMedium
                ?.copyWith(color: AppColors.blueColor),
          ),
        ),
        Expanded(
          child: CustomButton(
            onPressed: () {
              if (_loginFormKey.currentState!.validate()) {
                String email = _loginEmailTextEditingController.text;
                String password = _loginPasswordTextEditingController.text;
                if (email == emailAddress && password == passwords) {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.success(
                      message: "User Logged in sussessfully !!!",
                    ),
                  );
                  Navigation.replace(context, const DashboardPageView());
                } else {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "User credentials are not valid",
                    ),
                  );
                }
              }
            },
            text: "Login",
            buttonStyle: CustomButtonStyles.fillBlueGray.copyWith(
              backgroundColor:
                  const MaterialStatePropertyAll(AppColors.blueColor),
            ),
            buttonTextStyle: GharSubidhaTheme.getTextTheme(context)
                .bodyTextMedium
                ?.copyWith(
                    color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget formWidget(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          SizedBox(height: sizeX30 * Utils.getScalingFactor(context)),
          CustomTextFormField(
              hintText: "Email ",
              textInputType: TextInputType.emailAddress,
              autofocus: false,
              textInputAction: TextInputAction.done,
              controller: _loginEmailTextEditingController,
              validator: (value) => Utils.validate(value, field: "email"),
              isLightTheme: true),
          SizedBox(height: sizeX30 * Utils.getScalingFactor(context)),
          CustomTextFormField(
              hintText: "Password",
              textInputType: TextInputType.text,
              // obscureText: true,
              autofocus: false,
              textInputAction: TextInputAction.done,
              controller: _loginPasswordTextEditingController,
              validator: (value) => Utils.validate(value, field: "password"),
              isLightTheme: true),
          SizedBox(height: sizeX30 * Utils.getScalingFactor(context)),
        ],
      ),
    );
  }

  Widget _buildOrDivider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: paddingX10 * Utils.getScalingFactor(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: paddingX10 * Utils.getScalingFactor(context),
                bottom: paddingX4 * Utils.getScalingFactor(context)),
            child: SizedBox(
              width: sizeX120 * Utils.getScalingFactor(context),
              child: Divider(thickness: 1, color: AppColors.grey),
            ),
          ),
          Text(" OR  ",
              style: GharSubidhaTheme.getTextTheme(context).bodyTextMedium),
          Padding(
            padding: EdgeInsets.only(
                top: paddingX10 * Utils.getScalingFactor(context),
                bottom: paddingX4 * Utils.getScalingFactor(context)),
            child: SizedBox(
              width: sizeX120 * Utils.getScalingFactor(context),
              child: Divider(thickness: 1, color: AppColors.grey),
            ),
          )
        ],
      ),
    );
  }

  Widget googleSignIn(BuildContext context) {
    return CustomButton(
      text: "Sign In With Google",
      buttonStyle: CustomButtonStyles.signInGoogle.copyWith(
        backgroundColor: const MaterialStatePropertyAll(AppColors.primaryColor),
      ),
      buttonTextStyle: GharSubidhaTheme.getTextTheme(context)
          .bodyTextMedium
          ?.copyWith(color: AppColors.black, fontWeight: FontWeight.w600),
    );
  }

  Widget signUpWidget(BuildContext context) {
    return CustomButton(
      onPressed: () {
        Navigation.push(context, const RegisterPageView());
      },
      text: "Register",
      buttonStyle: CustomButtonStyles.signInGoogle.copyWith(
        backgroundColor: const MaterialStatePropertyAll(AppColors.coralRed),
      ),
      buttonTextStyle: GharSubidhaTheme.getTextTheme(context)
          .bodyTextMedium
          ?.copyWith(
              color: AppColors.primaryColor, fontWeight: FontWeight.w600),
    );
  }
}
