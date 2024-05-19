 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghar_subidha/core/utils/utils.dart';
  
part 'add_dates_state.dart';

class AddDatesCubit extends Cubit<List<DateTime>> {
  AddDatesCubit() : super(const []);

  List<DateTime> chekInCheckOut = []; 
  setCheckInCheckOutDates(String checkInCheckOut) async {
    chekInCheckOut = Utils().startAndEndDate(checkInCheckOut);
    emit(chekInCheckOut);
  }

  initialCheckInCheckOut() {
    emit([]);
  }
}
