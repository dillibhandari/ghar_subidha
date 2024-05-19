import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/dimens.dart';
import 'package:ghar_subidha/core/utils/utils.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/bloc/permission_bloc/permission_bloc.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/view/dashboard_page_view.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/widgets/bottom_sheet_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationWidget extends StatefulWidget {
  final FacilityModel facilityModel;
  const LocationWidget({super.key, required this.facilityModel});

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
              addMarker("loc1", const LatLng(-33.8732, 151.2008),
                  widget.facilityModel.name);
              addMarker("loc2", const LatLng(-33.8568, 151.2153),
                  widget.facilityModel.name);
              addMarker("loc3", const LatLng(-33.8523, 151.2108),
                  widget.facilityModel.name);
              addMarker("loc4", const LatLng(-33.8915, 151.2767),
                  widget.facilityModel.name);
              addMarker("loc5", const LatLng(-33.8430, 151.2410),
                  widget.facilityModel.name);
              addMarker("loc6", const LatLng(-33.8592, 151.2095),
                  widget.facilityModel.name);
              addMarker("loc7", const LatLng(-33.8705, 151.2089),
                  widget.facilityModel.name);
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
      position: location,
      infoWindow: InfoWindow(
        title: name,
        snippet: '\$50/hr',
        onTap: () {
          Utils().showBottomSheet(
            context,
            SizedBox(
              height: 300 * Utils.getScalingFactor(context),
              child: BottomSheetWidget(facilities: widget.facilityModel),
            ),
          );
        },
      ),
      onTap: () {},
    );

    _marker[id] = marker;
    setState(() {});
  }
}
