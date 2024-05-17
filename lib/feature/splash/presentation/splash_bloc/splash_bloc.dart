import 'package:ghar_subidha/feature/oboarding/domain/usecase/walkthrough_usecase.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, bool> {
  final WalkthroughUseCase walkthroughUseCase;
  SplashBloc(this.walkthroughUseCase) : super(false) {
    on<InitializeSplash>(_initializeSplash);
  }

  _initializeSplash(InitializeSplash event, Emitter<bool> emit) async {
    // check walkthrough seen  or not
    var result = await walkthroughUseCase.getWalkthroughSeen();
    emit(result);
  }
}
