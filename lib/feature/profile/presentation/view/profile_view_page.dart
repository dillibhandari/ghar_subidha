import 'package:flutter/material.dart';
import 'package:ghar_subidha/core/common_widgets/custom_button.dart';
import 'package:ghar_subidha/core/common_widgets/custom_image_view.dart';
import 'package:ghar_subidha/core/constants/image_constants.dart';
import 'package:ghar_subidha/core/navigation/navigation.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/dimens.dart';
import 'package:ghar_subidha/core/utils/utils.dart';
import 'package:ghar_subidha/feature/booking/presentation/widget/my_booking_list.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
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
              SizedBox(width: sizeX30 * Utils.getScalingFactor(context)),
              CustomImageView(
                  imagePath: ImageConstants().png.logo, fit: BoxFit.fitHeight),
            ],
          ),
        ),
      ),
      body: const ProfileBodyView(),
    );
  }
}

class ProfileBodyView extends StatelessWidget {
  const ProfileBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstants().png.profile,
            height: sizeX100 * Utils.getScalingFactor(context),
            width: sizeX100 * Utils.getScalingFactor(context),
          ),
          SizedBox(height: sizeX20 * Utils.getScalingFactor(context)),
          Text("Tanka Shahi",
              style: GharSubidhaTheme.getTextTheme(context)
                  .bodyTextLarge
                  ?.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: sizeX12 * Utils.getScalingFactor(context)),
          Text("tanka.shahi@gmail.com",
              style: GharSubidhaTheme.getTextTheme(context)
                  .bodyTextLarge
                  ?.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: sizeX24 * Utils.getScalingFactor(context)),
          CustomButton(
            height: sizeX40 * Utils.getScalingFactor(context),
            width: sizeX200 * Utils.getScalingFactor(context),
            onPressed: () =>
                Navigation.push(context, const MyBookingListWidget()),
            text: "My Booking",
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
          CustomButton(
            height: sizeX40 * Utils.getScalingFactor(context),
            width: sizeX180 * Utils.getScalingFactor(context),
            onPressed: () {
              // Navigation.replace(context, const DashboardPageView());
            },
            text: "Saved",
            buttonStyle: CustomButtonStyles.fillBlueGray.copyWith(
              backgroundColor:
                  const MaterialStatePropertyAll(AppColors.blueColor),
            ),
            buttonTextStyle: GharSubidhaTheme.getTextTheme(context)
                .bodyTextMedium
                ?.copyWith(
                    color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
