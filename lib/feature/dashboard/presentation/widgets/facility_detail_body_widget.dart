import 'package:flutter/material.dart';
import 'package:ghar_subidha/core/common_widgets/custom_button.dart';
import 'package:ghar_subidha/core/common_widgets/custom_image_view.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/dimens.dart';
import 'package:ghar_subidha/core/utils/utils.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/view/dashboard_page_view.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/widgets/bottom_sheet_widget.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/widgets/location_widget.dart';

class FacilityDetailsBodyWidget extends StatelessWidget {
  final FacilityModel facilityModel;
  const FacilityDetailsBodyWidget({super.key, required this.facilityModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _addressWidget( facilityModel, context),
        SizedBox(height: sizeX30 * Utils.getScalingFactor(context)),
        Expanded(child: LocationWidget(facilityModel:facilityModel))
      ],
    );
  }

  _addressWidget(FacilityModel facilityModel, BuildContext context) {
    return Padding(
      padding: Utils().getPadding(
          left: paddingX20 * Utils.getScalingFactor(context),
          right: paddingX20 * Utils.getScalingFactor(context),
          top: paddingX20 * Utils.getScalingFactor(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomImageView(
                imagePath: facilityModel.image,
                height: sizeX40 * Utils.getScalingFactor(context),
                width: sizeX40 * Utils.getScalingFactor(context),
              ),
              SizedBox(width: sizeX8 * Utils.getScalingFactor(context)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    facilityModel.name,
                    style: GharSubidhaTheme.getTextTheme(context)
                        .bodyTextLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: sizeX2 * Utils.getScalingFactor(context)),
                  Text(
                    "Sydney, Australia",
                    style: GharSubidhaTheme.getTextTheme(context)
                        .bodyTextMedium
                        ?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                        ),
                  )
                ],
              )
            ],
          ),
          CustomButton(
            onPressed: () {
              Utils().showBottomSheet(
                context,
                SizedBox(
                  height: 300 * Utils.getScalingFactor(context),
                  child:   BottomSheetWidget(facilities: facilityModel),
                ),
              );
            },
            margin: Utils().getMargin(all: 0),
            width: sizeX120 * Utils.getScalingFactor(context),
            height: sizeX30 * Utils.getScalingFactor(context),
            text: "Near me",
            rightIcon: const Icon(Icons.location_on_outlined),
            buttonStyle: CustomButtonStyles.fillBlueGray.copyWith(
              backgroundColor: const MaterialStatePropertyAll(
                AppColors.blueColor,
              ),
            ),
            buttonTextStyle: GharSubidhaTheme.getTextTheme(context)
                .bodyTextMedium
                ?.copyWith(
                    color: AppColors.primaryColor, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
