part of 'walkthrough_cubit.dart';

@immutable
abstract class WalkthroughState extends Equatable {}

class WalkthroughInitial extends WalkthroughState {
  @override
  List<Object?> get props => [];
}

class WalkthroughSlider extends WalkthroughState {

  final int index;
  WalkthroughSlider(this.index);

  @override
  List<Object?> get props => [index];
}

class WalkthroughSeen extends WalkthroughState {

  final bool hasSeen;
  WalkthroughSeen(this.hasSeen);

  @override
  List<Object?> get props => [hasSeen];
}
