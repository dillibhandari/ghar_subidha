import '../../domain/repositories/walkthrough_repository.dart';
import '../datasources/walkthrough_local_data_sources.dart';

class WalkthroughRepositoryImpl extends WalkthroughRepository {
  final WalkthroughLocalDataSources walkthroughLocalDataSources;

  WalkthroughRepositoryImpl(this.walkthroughLocalDataSources);

  @override
  Future<bool> getWalkthroughSeen() async {
    return await walkthroughLocalDataSources.getWalkthroughSeen();
  }

  @override
  Future<bool> setWalkthroughSeen() async {
    return await walkthroughLocalDataSources.setWalkthroughSeen();
  }
}
