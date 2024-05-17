import '../../../../core/constants/string_constants.dart';
import '../../../../core/helper/preferences/preferences.dart';

abstract class WalkthroughLocalDataSources {
  Future<bool> setWalkthroughSeen();
  Future<bool> getWalkthroughSeen();
}

class WalkthroughLocalDataSourcesImpl extends WalkthroughLocalDataSources {
  final Preferences preferences;
  WalkthroughLocalDataSourcesImpl(this.preferences);

  @override
  Future<bool> getWalkthroughSeen() async {
    return preferences.getBoolOrElse(StringConstants.walkthrough, false);
  }

  @override
  Future<bool> setWalkthroughSeen() async {
    return await preferences.setBool(StringConstants.walkthrough, true);
  }
}
