import 'package:flutter/material.dart';
import 'package:ghar_subidha/core/common_widgets/custom_button.dart';
import 'package:ghar_subidha/core/common_widgets/custom_image_view.dart';
import 'package:ghar_subidha/core/constants/image_constants.dart';
import 'package:ghar_subidha/core/navigation/navigation.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/dimens.dart';
import 'package:ghar_subidha/core/utils/utils.dart';
import 'package:ghar_subidha/feature/booking/presentation/widget/my_booking_list.dart';

class SuccessPageWidget extends StatelessWidget {
  const SuccessPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      body: const SuccessBodyWidget(),
    );
  }
}

class SuccessBodyWidget extends StatefulWidget {
  const SuccessBodyWidget({super.key});

  @override
  State<SuccessBodyWidget> createState() => _SuccessBodyWidgetState();
}

class _SuccessBodyWidgetState extends State<SuccessBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstants().png.tick,
          ),
          SizedBox(height: 20 * Utils.getScalingFactor(context)),
          Text(
            "Congratulation",
            style: GharSubidhaTheme.getTextTheme(context)
                .bodyTextLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: sizeX20 * Utils.getScalingFactor(context)),
          const Text("You have successfully book and paid."),
          SizedBox(height: sizeX40 * Utils.getScalingFactor(context)),
          CustomButton(
            onPressed: () {
              Navigation.replace(context, const MyBookingListWidget());
            },
            width: sizeX200 * Utils.getScalingFactor(context),
            text: "Check Your Booking",
            buttonStyle: CustomButtonStyles.signInGoogle.copyWith(
              backgroundColor:
                  const MaterialStatePropertyAll(AppColors.blueColor),
            ),
            buttonTextStyle: GharSubidhaTheme.getTextTheme(context)
                .bodyTextMedium
                ?.copyWith(
                    color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
