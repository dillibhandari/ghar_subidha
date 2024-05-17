import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_subidha/core/common_widgets/custom_button.dart';
import 'package:ghar_subidha/core/common_widgets/custom_image_view.dart';
import 'package:ghar_subidha/core/constants/image_constants.dart';
import 'package:ghar_subidha/core/navigation/navigation.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/dimens.dart';
import 'package:ghar_subidha/core/utils/utils.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/bloc/permission_bloc/permission_bloc.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/view/dashboard_page_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

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

class FacilityDetailsBodyWidget extends StatelessWidget {
  final FacilityModel facilityModel;
  const FacilityDetailsBodyWidget({super.key, required this.facilityModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _addressWidget(facilityModel.image, facilityModel.name, context),
        SizedBox(height: 30),
        Expanded(child: LocationWidget(name: facilityModel.name))
      ],
    );
  }

  _addressWidget(String image, String name, BuildContext context) {
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
                imagePath: image,
                height: sizeX40 * Utils.getScalingFactor(context),
                width: sizeX40 * Utils.getScalingFactor(context),
              ),
              SizedBox(width: sizeX8 * Utils.getScalingFactor(context)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
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
            margin: Utils().getMargin(all: 0),
            width: sizeX110 * Utils.getScalingFactor(context),
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

class LocationWidget extends StatefulWidget {
  final String name;
  const LocationWidget({super.key, required this.name});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  Completer<GoogleMapController> googleMapController = Completer();
  final Map<String, Marker> _marker = {};
  var maptype = MapType.satellite;
  bool enableSatalite = true;

  @override
  void initState() {
    context
        .read<PermissionBloc>()
        .add(const CheckPermission(Permission.location));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: Utils().height,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(8 * Utils.getScalingFactor(context))),
          width: double.infinity,
          child: GoogleMap(
            mapType: maptype,
            minMaxZoomPreference: MinMaxZoomPreference.unbounded,
            indoorViewEnabled: true,
            buildingsEnabled: true,
            cameraTargetBounds: CameraTargetBounds.unbounded,
            tiltGesturesEnabled: false,
            mapToolbarEnabled: false,
            layoutDirection: TextDirection.ltr,
            initialCameraPosition: const CameraPosition(
                target: LatLng(-33.8642, 151.2166), zoom: 14.4746),
            onMapCreated: (GoogleMapController controller) {
              googleMapController.complete(controller);
              addMarker("loc1", const LatLng(-33.8732, 151.2008), widget.name);
              addMarker("loc2", const LatLng(-33.8568, 151.2153), widget.name);
              addMarker("loc3", const LatLng(-33.8523, 151.2108), widget.name);
              addMarker("loc4", const LatLng(-33.8915, 151.2767), widget.name);
              addMarker("loc5", const LatLng(-33.8430, 151.2410), widget.name);
              addMarker("loc6", const LatLng(-33.8592, 151.2095), widget.name);
              addMarker("loc7", const LatLng(-33.8705, 151.2089), widget.name);
            },
            markers: _marker.values.toSet(),
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          ),
        ),
        Positioned(
          right: 12,
          top: 60,
          child: InkWell(
            onTap: () => setState(() {
              maptype = enableSatalite ? MapType.normal : MapType.satellite;
              enableSatalite = !enableSatalite;
            }),
            child: Container(
              height: sizeX36 * Utils.getScalingFactor(context),
              width: sizeX36 * Utils.getScalingFactor(context),
              decoration: BoxDecoration(
                color: AppColors.filterFrontColor.withOpacity(0.7),
                border: Border.all(color: AppColors.grey, width: 0.5),
              ),
              child: Center(
                  child: Icon(
                Icons.satellite_alt_sharp,
                color: enableSatalite ? AppColors.blueColor : AppColors.grey,
              )),
            ),
          ),
        )
      ],
    );
  }

  void addMarker(String id, LatLng location, String name) async {
    var marker = Marker(
      markerId: MarkerId(id),
      draggable: true,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      // icon: await BitmapDescriptor.fromAssetImage(
      //   ImageConfiguration.empty,
      //   ImageConstants().png.locationPointer,
      //   mipmaps: false,
      // ),
      position: location,
      infoWindow: InfoWindow(
        title: name,
        snippet: '\$50/hr',
        onTap: () {
          Utils().showBottomSheet(
              context,
              Container(
                height: 300,
              ));
        },
      ),
      onTap: () {},
    );

    _marker[id] = marker;
    setState(() {});
  }
}
