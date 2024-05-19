import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_subidha/feature/dashboard/presentation/view/dashboard_page_view.dart';
part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  List<Bookings> bookedFacility = [];

  bookFacility(Bookings booking) {
    emit(BookingLoading());
    bookedFacility.add(booking);
    emit(BookingSuccess(bookedFacility));
  }

  removeBooking(Bookings booking) {
    emit(BookingLoading());
    bookedFacility.remove(booking);
    emit(BookingSuccess(bookedFacility));
  }

  initialCheckInCheckOut() {
    bookedFacility.clear();
    emit(BookingInitial());
  }
}

class Bookings {
  final FacilityModel facilities;
  final String location;
  final String request;
  final String bookingDate;
  final String chooseTime;
  Bookings(
    this.facilities,
    this.location,
    this.request,
    this.bookingDate,
    this.chooseTime,
  );
}
