import 'package:flutter/material.dart';
import 'package:ghar_subidha/core/common_widgets/custom_button.dart';
import 'package:ghar_subidha/core/common_widgets/custom_image_view.dart';
import 'package:ghar_subidha/core/common_widgets/custom_text_field.dart';
import 'package:ghar_subidha/core/constants/image_constants.dart';
import 'package:ghar_subidha/core/navigation/navigation.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/dimens.dart';
import 'package:ghar_subidha/core/utils/utils.dart';
import 'package:ghar_subidha/feature/booking/presentation/widget/success_page.dart';

class PaymentPageView extends StatelessWidget {
  const PaymentPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: sizeX200 * Utils.getScalingFactor(context),
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: Padding(
          padding: Utils().getPadding(
              left: paddingX10 * Utils.getScalingFactor(context),
              top: paddingX10 * Utils.getScalingFactor(context)),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigation.pop(context),
                icon: const Icon(Icons.arrow_back_ios),
                color: AppColors.black,
              ),
              CustomImageView(
                  imagePath: ImageConstants().png.logo, fit: BoxFit.fitHeight),
            ],
          ),
        ),
      ),
      body: const PaymentBodyView(),
    );
  }
}

class PaymentBodyView extends StatelessWidget {
  const PaymentBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column( 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Booking Summary",
            style: GharSubidhaTheme.getTextTheme(context)
                .bodyTextMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10 * Utils.getScalingFactor(context),
          ),
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Total"), Text("\$50")]),
          SizedBox(
            height: 10 * Utils.getScalingFactor(context),
          ),
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gorkha Services"),
              ]),
          SizedBox(height: 10 * Utils.getScalingFactor(context)),
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Booking Amount"), Text("\$50")]),
          SizedBox(height: 10 * Utils.getScalingFactor(context)),
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Addition charge"), Text("\$0")]),
          SizedBox(height: 10 * Utils.getScalingFactor(context)),
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Discount"), Text("\$0")]),
          SizedBox(height: 20 * Utils.getScalingFactor(context)),
          paymentMethod(context),
          SizedBox(height: 20 * Utils.getScalingFactor(context)),
          fields(context),
          const Spacer(),
          continusBtn(context)
        ],
      ),
    );
  }

  Widget paymentMethod(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Methos",
          style: GharSubidhaTheme.getTextTheme(context)
              .bodyTextLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: sizeX16 * Utils.getScalingFactor(context)),
        Row(
          children: [
            Expanded(
                child: CustomImageView(imagePath: ImageConstants().png.card1)),
            SizedBox(
              width: sizeX16 * Utils.getScalingFactor(context),
            ),
            Expanded(
                child: CustomImageView(imagePath: ImageConstants().png.card2)),
            SizedBox(
              width: sizeX16 * Utils.getScalingFactor(context),
            ),
            Expanded(
                child: CustomImageView(imagePath: ImageConstants().png.card3))
          ],
        )
      ],
    );
  }

  Widget fields(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          isLightTheme: true,
          hintText: "Name on card ",
          hintStyle: GharSubidhaTheme.getTextTheme(context).bodyTextMedium,
        ),
        SizedBox(height: 20 * Utils.getScalingFactor(context)),
        CustomTextFormField(
          isLightTheme: true,
          hintText: "Card number ",
          hintStyle: GharSubidhaTheme.getTextTheme(context).bodyTextMedium,
        ),
        SizedBox(height: 20 * Utils.getScalingFactor(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextFormField(
              width: 100 * Utils.getScalingFactor(context),
              isLightTheme: true,
              hintText: "Expiry month ",
              hintStyle: GharSubidhaTheme.getTextTheme(context).bodyTextMedium,
            ),
            CustomTextFormField(
              width: 120 * Utils.getScalingFactor(context),
              isLightTheme: true,
              hintText: "Expiry Year ",
              hintStyle: GharSubidhaTheme.getTextTheme(context).bodyTextMedium,
            ),
            CustomTextFormField(
              width: 60 * Utils.getScalingFactor(context),
              isLightTheme: true,
              hintText: "CVV ",
              hintStyle: GharSubidhaTheme.getTextTheme(context).bodyTextMedium,
            ),
          ],
        )
      ],
    );
  }

  continusBtn(BuildContext context) {
    return CustomButton(
      onPressed: () {
        Navigation.replace(context, const SuccessPageWidget());
      },
      text: "Continue",
      buttonStyle: CustomButtonStyles.signInGoogle.copyWith(
        backgroundColor: const MaterialStatePropertyAll(AppColors.blueColor),
      ),
      buttonTextStyle: GharSubidhaTheme.getTextTheme(context)
          .bodyTextMedium
          ?.copyWith(
              color: AppColors.primaryColor, fontWeight: FontWeight.w600),
    );
  }
}
