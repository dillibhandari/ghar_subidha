import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_subidha/core/common_widgets/custom_button.dart';
import 'package:ghar_subidha/core/common_widgets/custom_image_view.dart';
import 'package:ghar_subidha/core/common_widgets/custom_text_field.dart';
import 'package:ghar_subidha/core/common_widgets/top_snack_bar.dart';
import 'package:ghar_subidha/core/constants/image_constants.dart';
import 'package:ghar_subidha/core/navigation/navigation.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:ghar_subidha/core/utils/dimens.dart';
import 'package:ghar_subidha/core/utils/utils.dart';
import 'package:ghar_subidha/feature/booking/presentation/bloc/add_dates_cubit/add_dates_cubit.dart';
import 'package:ghar_subidha/feature/booking/presentation/bloc/booking_cubbit/booking_cubit.dart';
import 'package:ghar_subidha/feature/booking/presentation/widget/payment_field_widget.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/view/dashboard_page_view.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingPage extends StatefulWidget {
  final FacilityModel facilities;
  const BookingPage({super.key, required this.facilities});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
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
        body: BookingBodyView(
          facilities: widget.facilities,
        ));
  }
}

class BookingBodyView extends StatefulWidget {
  final FacilityModel facilities;
  const BookingBodyView({super.key, required this.facilities});

  @override
  State<BookingBodyView> createState() => _BookingBodyViewState();
}

class _BookingBodyViewState extends State<BookingBodyView> {
  String selectedDate = '';
  String dateCount = '';
  String range = '';
  String rangeCount = '';
  int? selectedIndex;
  final GlobalKey<FormState> _bookFormKey = GlobalKey<FormState>();

  final TextEditingController _locationTextEditingController =
      TextEditingController(text: "Sydney, Australia");

  final TextEditingController _requestTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: Utils().getPadding(
            left: paddingX20 * Utils.getScalingFactor(context),
            right: paddingX20 * Utils.getScalingFactor(context),
            top: paddingX20 * Utils.getScalingFactor(context)),
        child: Form(
          key: _bookFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sizeX10 * Utils.getScalingFactor(context)),
              addressWidget(context),
              SizedBox(height: sizeX30 * Utils.getScalingFactor(context)),
              Text(
                widget.facilities.companyName,
                style: GharSubidhaTheme.getTextTheme(context)
                    .bodyTextLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10 * Utils.getScalingFactor(context),
              ),
              locationTextfield(context),
              SizedBox(height: 10 * Utils.getScalingFactor(context)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Other Request",
                    style: GharSubidhaTheme.getTextTheme(context).bodyTextLarge,
                  ),
                  SizedBox(height: 10 * Utils.getScalingFactor(context)),
                  Container(
                    height: sizeX100 * Utils.getScalingFactor(context),
                    //  color: AppColors.accent,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.black),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        SizedBox(height: 10 * Utils.getScalingFactor(context)),
                        Expanded(
                          child: TextField(
                              decoration: const InputDecoration(),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              expands: true, // <-- SEE HERE
                              controller: _requestTextEditingController),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10 * Utils.getScalingFactor(context)),
              Text(
                "Appointment Booking",
                style: GharSubidhaTheme.getTextTheme(context).bodyTextLarge,
              ),
              SizedBox(
                  height: 280 * Utils.getScalingFactor(context),
                  child: addDateWidget()),
              chooseTimeWidget(),
              SizedBox(height: sizeX20 * Utils.getScalingFactor(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Booking Amount :\$50"),
                  CustomButton(
                    onPressed: () {
                      if (_bookFormKey.currentState!.validate()) {
                        String location = _locationTextEditingController.text;
                        String request = _requestTextEditingController.text;
                        if (location == "" ||
                            selectedDate == "" ||
                            selectedIndex == null) {
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.error(
                              message: "Please fill valid requiremnts",
                            ),
                          );
                        } else {
                          context.read<BookingCubit>().bookFacility(Bookings(
                              widget.facilities,
                              location,
                              request,
                              selectedDate,
                              listOfSchedule[selectedIndex!].schedule));
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.success(
                              message: "Service Booked Successfuly",
                            ),
                          );
                          Navigation.push(context, const PaymentPageView());
                        }
                      }
                    },
                    width: sizeX100 * Utils.getScalingFactor(context),
                    height: sizeX40 * Utils.getScalingFactor(context),
                    text: "Continue",
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
              SizedBox(height: sizeX20 * Utils.getScalingFactor(context)),
            ],
          ),
        ),
      ),
    );
  }

  Row locationTextfield(BuildContext context) {
    return Row(
      children: [
        const Text("Location"),
        SizedBox(width: sizeX20 * Utils.getScalingFactor(context)),
        CustomTextFormField(
            hintText: " Please Enter Location ",
            height: sizeX30 * Utils.getScalingFactor(context),
            width: sizeX180 * Utils.getScalingFactor(context),
            textInputType: TextInputType.emailAddress,
            autofocus: false,
            textInputAction: TextInputAction.done,
            hintStyle: GharSubidhaTheme.getTextTheme(context).bodyTextSmall,
            controller: _locationTextEditingController,
            // validator: (value) => Utils.validate(value, field: "location"),
            isLightTheme: true),
        SizedBox(height: sizeX40 * Utils.getScalingFactor(context)),
      ],
    );
  }

  Widget addressWidget(BuildContext context) {
    return Row(
      children: [
        CustomImageView(
          imagePath: widget.facilities.image,
          height: sizeX40 * Utils.getScalingFactor(context),
          width: sizeX40 * Utils.getScalingFactor(context),
        ),
        SizedBox(width: sizeX8 * Utils.getScalingFactor(context)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.facilities.name.toUpperCase(),
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
    );
  }

  addDateWidget() {
    return BlocBuilder<AddDatesCubit, List<DateTime>>(
        builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(
              Radius.circular(radiusX20 * Utils.getScalingFactor(context))),
        ),
        padding: Utils().getPadding(
          top: paddingX10 * Utils.getScalingFactor(context),
        ),
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.single,
          view: DateRangePickerView.month,
          navigationDirection: DateRangePickerNavigationDirection.horizontal,
          enableMultiView: false,
          showNavigationArrow: true,
          initialDisplayDate: DateTime.now(),
          onSelectionChanged: onSelectionChanged,
          todayHighlightColor: Colors.black,
          selectionColor: Colors.grey,
          backgroundColor: AppColors.primaryColor,
          cancelText: "cancle",
          monthCellStyle: const DateRangePickerMonthCellStyle(
            todayTextStyle: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColors.black),
          ),
          extendableRangeSelectionDirection:
              ExtendableRangeSelectionDirection.both,
          selectionTextStyle: GharSubidhaTheme.getTextTheme(context)
              .bodyTextMedium
              ?.copyWith(color: AppColors.primaryColor),
          endRangeSelectionColor: AppColors.blueColor,
          rangeSelectionColor: AppColors.blueColor.withOpacity(0.5),
          allowViewNavigation: true,
          minDate: DateTime.now(),
          headerStyle: DateRangePickerHeaderStyle(
              textStyle: GharSubidhaTheme.getTextTheme(context)
                  .headingSmall
                  ?.copyWith(color: AppColors.black)),
        ),
      );
    });
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        context.read<AddDatesCubit>().setCheckInCheckOutDates(range);
        DateTime dateTime = DateTime.parse(range);

        // Format the DateTime object to the desired format
        String formattedDate = DateFormat('MMMM d, yyyy').format(dateTime);

        selectedDate = formattedDate;
      } else if (args.value is DateTime) {
        selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        dateCount = args.value.length.toString();
      } else {
        rangeCount = args.value.length.toString();
      }
    });
  }

  chooseTimeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Choose Time",
            style: GharSubidhaTheme.getTextTheme(context)
                .bodyTextLarge
                ?.copyWith(fontWeight: FontWeight.w500)),
        SizedBox(height: sizeX10 * Utils.getScalingFactor(context)),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          runAlignment: WrapAlignment.spaceEvenly,
          alignment: WrapAlignment.start,
          runSpacing: sizeX12 * Utils.getScalingFactor(context),
          spacing: sizeX16 * Utils.getScalingFactor(context),
          children: [
            ...List.generate(
              listOfSchedule.length,
              (index) {
                bool isSelected = selectedIndex == index;

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    height: sizeX40 * Utils.getScalingFactor(context),
                    width: sizeX100 * Utils.getScalingFactor(context),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.blueColor : AppColors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      listOfSchedule[index].schedule,
                      style: GharSubidhaTheme.getTextTheme(context)
                          .bodyTextMedium
                          ?.copyWith(
                            color: isSelected
                                ? AppColors.primaryColor
                                : AppColors.black,
                          ),
                    )),
                  ),
                );
              },
            )
          ],
        ),
        SizedBox(height: sizeX10 * Utils.getScalingFactor(context)),
      ],
    );
  }
}

class Dates {
  final String schedule;
  Dates(this.schedule);
}

List<Dates> listOfSchedule = [
  Dates("8 AM"),
  Dates("9 AM"),
  Dates("10 AM"),
  Dates("11 AM"),
  Dates("12 PM"),
  Dates("2 PM"),
  Dates("3 PM"),
  Dates("4 PM"),
  Dates("5 PM"),
];
