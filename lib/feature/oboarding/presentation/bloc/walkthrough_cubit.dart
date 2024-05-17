import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/walkthrough_usecase.dart';
import 'package:meta/meta.dart';
part 'walkthrough_state.dart';

class WalkthroughCubit extends Cubit<WalkthroughState> {
  final WalkthroughUseCase walkthroughUseCase;

  WalkthroughCubit(this.walkthroughUseCase) : super(WalkthroughInitial());

  final sliderItems = [
    {
      "image": "resources/images/slide_1.png",
      "title": "Remember us for all home care service",
      "des_title1": "One",
      "des_title2": "Stop Solution",
      "description": "solution for you all home "
    },
    {
      "image": "resources/images/slide_2.png",
      "title": "Make an Appointment and we take care rest.",
      "des_title1": "One Click ",
      "des_title2": "All Solutions",
      "description": "Home service is better now."
    },
  ];

  setIndex(int index) {
    emit(WalkthroughSlider(index));
  }

  // getWalkthroughSeen() async {
  //   final result = await walkthroughUseCase.getWalkthroughSeen();
  //   emit(WalkthroughSeen(result));
  // }

  setWalkthroughSeen() async {
    await walkthroughUseCase.setWalkthroughSeen();
  }
}
