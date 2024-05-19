import 'package:flutter/material.dart';
import 'package:ghar_subidha/core/common_widgets/custom_button.dart';
 import 'package:ghar_subidha/core/navigation/navigation.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/dimens.dart';
import 'package:ghar_subidha/core/utils/utils.dart';
import 'package:ghar_subidha/feature/booking/presentation/view/booking_page_view.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/view/dashboard_page_view.dart';

class BottomSheetWidget extends StatelessWidget {
  final FacilityModel facilities;
  const BottomSheetWidget({super.key, required this.facilities});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding:
                EdgeInsets.all(paddingX20 * Utils.getScalingFactor(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gorkha Services",
                      style:
                          GharSubidhaTheme.getTextTheme(context).headingSmall,
                    ),
                    SizedBox(height: sizeX30 * Utils.getScalingFactor(context)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Our services",
                            style: GharSubidhaTheme.getTextTheme(context)
                                .headingSmall),
                        SizedBox(
                            height: sizeX20 * Utils.getScalingFactor(context)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Service one",
                                style: GharSubidhaTheme.getTextTheme(context)
                                    .bodyTextMedium),
                            SizedBox(
                                width:
                                    sizeX40 * Utils.getScalingFactor(context)),
                            Text("Service one",
                                style: GharSubidhaTheme.getTextTheme(context)
                                    .bodyTextMedium),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Service one",
                                style: GharSubidhaTheme.getTextTheme(context)
                                    .bodyTextMedium),
                            SizedBox(
                                width:
                                    sizeX40 * Utils.getScalingFactor(context)),
                            Text("Service one",
                                style: GharSubidhaTheme.getTextTheme(context)
                                    .bodyTextMedium),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                CustomButton(
                  height: sizeX50 * Utils.getScalingFactor(context),
                  width: sizeX120 * Utils.getScalingFactor(context),
                  text: "\$ 50 / hr",
                  onPressed: () {
                    Navigation.push(
                        context, BookingPage(facilities: facilities));
                  },
                  buttonStyle: CustomButtonStyles.fillBlueGray.copyWith(
                    backgroundColor:
                        const MaterialStatePropertyAll(AppColors.blueColor),
                  ),
                  buttonTextStyle: GharSubidhaTheme.getTextTheme(context)
                      .bodyTextMedium
                      ?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: AppColors.coralRed,
            padding: Utils().getMargin(
                left: paddingX10 * Utils.getScalingFactor(context),
                right: paddingX10 * Utils.getScalingFactor(context)),
            child: Row(
              children: [
                Text(
                  "NOTE :",
                  style: GharSubidhaTheme.getTextTheme(context)
                      .bodyTextMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 10 * Utils.getScalingFactor(context)),
                Expanded(
                    child: Text(
                  "Photo of the field is required and additional charge will be applied.",
                  style: GharSubidhaTheme.getTextTheme(context).bodyTextSmall,
                ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
