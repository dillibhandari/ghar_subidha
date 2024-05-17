import 'package:flutter/material.dart';
import 'package:ghar_subidha/core/common_widgets/custom_button.dart';
import 'package:ghar_subidha/core/common_widgets/custom_image_view.dart';
import 'package:ghar_subidha/core/constants/image_constants.dart';
import 'package:ghar_subidha/core/navigation/navigation.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/dimens.dart';
import 'package:ghar_subidha/core/utils/utils.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/widgets/facility_details_widget.dart';
import 'package:ghar_subidha/feature/profile/presentation/view/profile_view_page.dart';

class DashboardPageView extends StatefulWidget {
  const DashboardPageView({super.key});

  @override
  State<DashboardPageView> createState() => _DashboardPageViewState();
}

class _DashboardPageViewState extends State<DashboardPageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          leadingWidth: sizeX100 * Utils.getScalingFactor(context),
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(
                left: paddingX10 * Utils.getScalingFactor(context),
                top: paddingX10 * Utils.getScalingFactor(context)),
            child: CustomImageView(
                imagePath: ImageConstants().png.logo, fit: BoxFit.fitHeight),
          ),
          actions: [
            Padding(
              padding:
                  EdgeInsets.all(paddingX10 * Utils.getScalingFactor(context)),
              child: SizedBox(
                width: sizeX100 * Utils.getScalingFactor(context),
                height: sizeX30 * Utils.getScalingFactor(context),
                child: CustomButton(
                  height: sizeX30 * Utils.getScalingFactor(context),
                  onPressed: () =>
                      Navigation.replace(context, const DashboardPageView()),
                  text: "My Booking",
                  buttonStyle: CustomButtonStyles.fillBlueGray.copyWith(
                    backgroundColor: const MaterialStatePropertyAll(
                      AppColors.blueColor,
                    ),
                  ),
                  buttonTextStyle: GharSubidhaTheme.getTextTheme(context)
                      .bodyTextSmall
                      ?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
        body: const DashboardBodyView());
  }
}

class DashboardBodyView extends StatelessWidget {
  const DashboardBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingX16 * Utils.getScalingFactor(context)),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: Utils().height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 30),
              AddressAndProfile(),
              SizedBox(height: sizeX20 * Utils.getScalingFactor(context)),

              BigAdsWidget(),
              SizedBox(height: sizeX16 * Utils.getScalingFactor(context)),
              OurMenuWidget(),
              SizedBox(height: sizeX16 * Utils.getScalingFactor(context)),

              FacilityMenuList()
            ],
          ),
        ),
      ),
    );
  }
}

class AddressAndProfile extends StatelessWidget {
  const AddressAndProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: 'Your Address : ',
                  style: GharSubidhaTheme.getTextTheme(context)
                      .bodyTextMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const TextSpan(text: '  Sydney, Australia'),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigation.push(context, const ProfilePageView());
          },
          child: CircleAvatar(
            backgroundColor: AppColors.transparent,
            backgroundImage: AssetImage(
              ImageConstants().png.profile,
            ),
          ),
        ),
      ],
    );
  }
}

class BigAdsWidget extends StatelessWidget {
  const BigAdsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(radiusX8 * Utils.getScalingFactor(context)),
      child: CustomImageView(
        imagePath: ImageConstants().png.ads,
        fit: BoxFit.cover,
        height: sizeX200 * Utils.getScalingFactor(context),
      ),
    );
  }
}

class OurMenuWidget extends StatelessWidget {
  const OurMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.menuColor,
                borderRadius: BorderRadius.circular(
                    radiusX20 * Utils.getScalingFactor(context)),
                border: Border.all(color: AppColors.grey)),
            height: sizeX30 * Utils.getScalingFactor(context),
            width: sizeX100 * Utils.getScalingFactor(context),
            child: const Center(
              child: Text("Our Menu"),
            ),
          ),
        ),
        SizedBox(width: sizeX4 * Utils.getScalingFactor(context)),
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            height: sizeX2 * Utils.getScalingFactor(context),
            color: AppColors.grey,
          ),
        )
      ],
    );
  }
}

class FacilityMenuList extends StatelessWidget {
  const FacilityMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        shrinkWrap: true,
        padding: Utils().getPadding(all: 0),
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.7),
        crossAxisCount: 3,
        crossAxisSpacing: sizeX10 * Utils.getScalingFactor(context),
        mainAxisSpacing: sizeX10 * Utils.getScalingFactor(context),
        children: List.generate(
          listOfFacilityModel.length,
          (index) {
            return InkWell(
              onTap: () {
                Navigation.push(
                    context,
                    FacilityDetailsWidget(
                        facilityModel: listOfFacilityModel[index]));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusX10),
                    border: Border.all(color: AppColors.grey)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            height: sizeX10 * Utils.getScalingFactor(context)),
                        CustomImageView(
                          imagePath: listOfFacilityModel[index].image,
                          height: sizeX54 * Utils.getScalingFactor(context),
                          width: sizeX54 * Utils.getScalingFactor(context),
                        )
                      ],
                    ),
                    SizedBox(height: sizeX6 * Utils.getScalingFactor(context)),
                    Text(
                      textAlign: TextAlign.center,
                      listOfFacilityModel[index].name,
                      style: GharSubidhaTheme.getTextTheme(context)
                          .bodyTextMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: sizeX2 * Utils.getScalingFactor(context)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FacilityModel {
  final int id;
  final String image;
  final String name;
  FacilityModel(this.id, this.image, this.name);
}

List<FacilityModel> listOfFacilityModel = [
  FacilityModel(1, ImageConstants().png.electricity, "Electricity"),
  FacilityModel(2, ImageConstants().png.cleaning, "Cleaning"),
  FacilityModel(3, ImageConstants().png.plumber, "Plumber"),
  FacilityModel(4, ImageConstants().png.salon, "Salon at Home"),
  FacilityModel(5, ImageConstants().png.painting, "Painting"),
  FacilityModel(6, ImageConstants().png.pestControl, "Pest Control"),
  FacilityModel(7, ImageConstants().png.makeup, "Make up & Hairstyling"),
  FacilityModel(8, ImageConstants().png.massage, "Massage at Home"),
  FacilityModel(9, ImageConstants().png.repair, "Appliances Repair"),
];
