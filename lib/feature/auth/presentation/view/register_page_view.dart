import 'package:flutter/material.dart';
import 'package:ghar_subidha/core/common_widgets/custom_button.dart';
import 'package:ghar_subidha/core/common_widgets/custom_image_view.dart';
import 'package:ghar_subidha/core/common_widgets/custom_text_field.dart';
import 'package:ghar_subidha/core/constants/image_constants.dart';
import 'package:ghar_subidha/core/navigation/navigation.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/dimens.dart';
import 'package:ghar_subidha/core/utils/utils.dart';

import 'login_page_view.dart';

class RegisterPageView extends StatelessWidget {
  const RegisterPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigation.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: AppColors.black),
      ),
      body: Padding(
        padding: Utils().getPadding(
          all: paddingX20 * Utils.getScalingFactor(context),
        ),
        child: const RegisterBodyView(),
      ),
    );
  }
}

class RegisterBodyView extends StatelessWidget {
  const RegisterBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CustomImageView(
            imagePath: ImageConstants().png.logo,
            height: sizeX100 * Utils.getScalingFactor(context),
          ),
          formWidget(context),
          CustomButton(
            text: "Register",
            buttonStyle: CustomButtonStyles.fillBlueGray.copyWith(
              backgroundColor:
                  const MaterialStatePropertyAll(AppColors.blueColor),
            ),
            buttonTextStyle: GharSubidhaTheme.getTextTheme(context)
                .bodyTextMedium
                ?.copyWith(
                    color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: sizeX20 * Utils.getScalingFactor(context)),
          _buildOrDivider(context),
          SizedBox(height: sizeX30 * Utils.getScalingFactor(context)),
          googleSignIn(context),
          SizedBox(height: sizeX20 * Utils.getScalingFactor(context)),
          signUpWidget(context)
        ],
      ),
    );
  }

  Widget formWidget(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: sizeX30 * Utils.getScalingFactor(context)),
        const CustomTextFormField(
            hintText: "Full Name",
            autofocus: false,
            textInputType: TextInputType.text,
            isLightTheme: true),
        SizedBox(height: sizeX20 * Utils.getScalingFactor(context)),
        const CustomTextFormField(
            hintText: "Email Address",
            textInputType: TextInputType.text,
            autofocus: false,
            textInputAction: TextInputAction.done,
            isLightTheme: true),
        SizedBox(height: sizeX30 * Utils.getScalingFactor(context)),
        const CustomTextFormField(
            hintText: "Address",
            textInputType: TextInputType.text,
            obscureText: true,
            autofocus: false,
            textInputAction: TextInputAction.done,
            isLightTheme: true),
        SizedBox(height: sizeX30 * Utils.getScalingFactor(context)),
        const CustomTextFormField(
            hintText: "Password",
            textInputType: TextInputType.text,
            obscureText: true,
            autofocus: false,
            textInputAction: TextInputAction.done,
            isLightTheme: true),
        SizedBox(height: sizeX30 * Utils.getScalingFactor(context)),
        const CustomTextFormField(
            hintText: "Confirm Password",
            textInputType: TextInputType.text,
            obscureText: true,
            autofocus: false,
            textInputAction: TextInputAction.done,
            isLightTheme: true),
        SizedBox(height: sizeX30 * Utils.getScalingFactor(context)),
      ],
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
        Navigation.replace(context, const LoginPageView());
      },
      text: " Login ",
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
