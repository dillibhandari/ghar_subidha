part of 'add_dates_cubit.dart';

sealed class AddDatesState extends Equatable {
  final List<DateTime> listOfCheckInCheckOut;
  const AddDatesState(this.listOfCheckInCheckOut);

  @override
  List<Object> get props => [];
}

final class AddDatesInitial extends AddDatesState {
  const AddDatesInitial(super.listOfCheckInCheckOut);
}
