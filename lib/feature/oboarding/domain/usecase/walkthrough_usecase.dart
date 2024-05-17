import '../repositories/walkthrough_repository.dart';

class WalkthroughUseCase extends WalkthroughRepository {
  final WalkthroughRepository walkthroughRepository;

  WalkthroughUseCase(this.walkthroughRepository);

  @override
  Future<bool> getWalkthroughSeen() async {
    return await walkthroughRepository.getWalkthroughSeen();
  }

  @override
  Future<bool> setWalkthroughSeen() async {
    return await walkthroughRepository.setWalkthroughSeen();
  }
}
