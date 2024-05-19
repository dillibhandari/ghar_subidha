 import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_subidha/core/common_widgets/custom_image_view.dart';
import 'package:ghar_subidha/core/common_widgets/top_snack_bar.dart';
import 'package:ghar_subidha/core/constants/image_constants.dart';
import 'package:ghar_subidha/core/navigation/navigation.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/dimens.dart';
import 'package:ghar_subidha/core/utils/utils.dart';
import 'package:ghar_subidha/feature/booking/presentation/bloc/booking_cubbit/booking_cubit.dart';
import 'package:intl/intl.dart';

class MyBookingListWidget extends StatelessWidget {
  const MyBookingListWidget({super.key});

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
                  imagePath: ImageConstants().png.logo, fit: BoxFit.fitHeight),
            ],
          ),
        ),
      ),
      body: const MyBookingBodyWidget(),
    );
  }
}

class MyBookingBodyWidget extends StatelessWidget {
  const MyBookingBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(paddingX20 * Utils.getScalingFactor(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Booking",
              style: GharSubidhaTheme.getTextTheme(context)
                  .headingSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20 * Utils.getScalingFactor(context)),
            bookingDataWidget(context)
          ],
        ),
      ),
    );
  }

  Widget bookingDataWidget(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        if (state is BookingInitial) {
          return SizedBox(
            height: 500 * Utils.getScalingFactor(context),
            child: const Center(
              child: Text("Booking list is empty"),
            ),
          );
        } else if (state is BookingSuccess) {
          if (state.bookingList.isEmpty) {
            return SizedBox(
              height: 500 * Utils.getScalingFactor(context),
              child: const Center(
                child: Text("Booking list is empty"),
              ),
            );
          } else {
            return SizedBox(
              child: Column(
                children: [
                  ...List.generate(
                    state.bookingList.length,
                    (index) => Container(
                      // height: 190,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.grey)),
                      margin: Utils().getMargin(bottom: 10),
                      child: displayData(context, state.bookingList[index]),
                    ),
                  )
                ],
              ),
            );
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget displayData(BuildContext context, Bookings bookings) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bookingTopWidget(bookings, context),
          SizedBox(height: sizeX10),
          serviceWidget(bookings, context),
          SizedBox(height: sizeX10 * Utils.getScalingFactor(context)),
          appointmentDateWidget(bookings, context),
          removeIconWidget(context, bookings)
        ],
      ),
    );
  }

  Widget bookingTopWidget(Bookings bookings, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: bookings.facilities.image,
              height: sizeX40 * Utils.getScalingFactor(context),
              width: sizeX40 * Utils.getScalingFactor(context),
            ),
            SizedBox(width: 10 * Utils.getScalingFactor(context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookings.facilities.name,
                  style: GharSubidhaTheme.getTextTheme(context)
                      .bodyTextLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  "Sydney, Australia",
                  style: GharSubidhaTheme.getTextTheme(context)
                      .bodyTextMedium
                      ?.copyWith(
                          fontWeight: FontWeight.w600, color: AppColors.grey),
                )
              ],
            )
          ],
        ),
        Text(
          "\$50",
          style: GharSubidhaTheme.getTextTheme(context)
              .bodyTextLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  Widget serviceWidget(Bookings bookings, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service Booked",
          style: GharSubidhaTheme.getTextTheme(context)
              .bodyTextLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: sizeX6 * Utils.getScalingFactor(context)),
        Row(
          children: [
            Expanded(
              child: Text(
                "${bookings.facilities.name} Service",
                style: GharSubidhaTheme.getTextTheme(context).bodyTextMedium,
              ),
            ),
            SizedBox(width: sizeX20 * Utils.getScalingFactor(context)),
            const Icon(Icons.location_on),
            Expanded(
              child: Text(
                bookings.location,
                style: GharSubidhaTheme.getTextTheme(context).bodyTextMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget appointmentDateWidget(Bookings bookings, BuildContext context) {
    DateTime dateTime = DateTime.parse(bookings.bookingDate);
    String formattedDate = DateFormat('MMMM d, yyyy').format(dateTime);

    return Row(
      children: [
        Text(
          "Appointment Date: ",
          style: GharSubidhaTheme.getTextTheme(context)
              .bodyTextMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(width: 10 * Utils.getScalingFactor(context)),
        Text(formattedDate),
        SizedBox(width: 10 * Utils.getScalingFactor(context)),
        Row(
          children: [
            const Icon(Icons.watch_later_outlined),
            const SizedBox(width: 1),
            Text(
              bookings.chooseTime,
              style: GharSubidhaTheme.getTextTheme(context).bodyTextSmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget removeIconWidget(BuildContext context, Bookings booking) {
    return Align(
      alignment: Alignment.bottomRight,
      child: IconButton(
        onPressed: () {
          showAlertDialog(context, booking);
        },
        icon: Icon(
          Icons.delete,
          size: sizeX26 * Utils.getScalingFactor(context),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, Bookings booking) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "No",
        style: GharSubidhaTheme.getTextTheme(context)
            .bodyTextMedium
            ?.copyWith(color: AppColors.black),
      ),
      onPressed: () {
        Navigation.pop(context);
      },
    );
    Widget deleteButton = TextButton(
      child: Text(
        "Yes",
        style: GharSubidhaTheme.getTextTheme(context)
            .bodyTextMedium
            ?.copyWith(color: AppColors.black),
      ),
      onPressed: () {
        context.read<BookingCubit>().removeBooking(booking);
        Navigation.pop(context);
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: "Booked Service Removed Successfuly",
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Warning !"),
      content: const Text(
          "Are you sure to delete your booking. After deleting you cannot retrive your booking in future."),
      actions: [cancelButton, deleteButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
