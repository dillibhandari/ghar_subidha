import 'package:flutter/material.dart';
import 'package:ghar_subidha/core/common_widgets/custom_image_view.dart';
import 'package:ghar_subidha/core/constants/image_constants.dart';
import 'package:ghar_subidha/core/navigation/navigation.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/dimens.dart';
import 'package:ghar_subidha/core/utils/utils.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/view/dashboard_page_view.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/widgets/facility_detail_body_widget.dart';

class FacilityDetailsWidget extends StatelessWidget {
  final FacilityModel facilityModel;
  const FacilityDetailsWidget({super.key, required this.facilityModel});

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
                CustomImageView(
                    imagePath: ImageConstants().png.logo,
                    fit: BoxFit.fitHeight),
              ],
            ),
          ),
        ),
        body: FacilityDetailsBodyWidget(facilityModel: facilityModel));
  }
}
