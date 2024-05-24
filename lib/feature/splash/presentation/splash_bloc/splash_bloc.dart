import 'dart:async';

import 'package:ghar_subidha/feature/oboarding/domain/usecase/walkthrough_usecase.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final WalkthroughUseCase walkthroughUseCase;
  SplashBloc(this.walkthroughUseCase) : super(SplashInitial()) {
    on<InitializeSplash>(_initializeSplash);
  }

  FutureOr<void> _initializeSplash(
      InitializeSplash event, Emitter<SplashState> emit) async {
    emit(SplashLoading());
    var result = await walkthroughUseCase.getWalkthroughSeen();
    if (!result) {
      emit(GoWalkThrough());
    } else {
      emit(GoLogin());
    }
  }
}
