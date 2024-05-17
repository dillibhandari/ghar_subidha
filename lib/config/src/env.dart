part of '../configuration.dart';

abstract class Env {
  Env() {
    _init();
  }

  _init() {
    if (kReleaseMode) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }

    unawaited(
      runZonedGuarded(
        () async {
          WidgetsFlutterBinding.ensureInitialized();
          await di.initialize();
          // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
          // BuildConfig.init(flavor: const String.fromEnvironment('development'));
          BuildConfig.init(flavor: "development");
          GharSubidhaTheme.initUiOverlayStyle();

          usePathUrlStrategy();

          final app = await onCreate();

          runApp(app);
        },
        (error, stack) {
          printError(error, stack);
        },
      ),
    );
  }

  FutureOr<Widget> onCreate();

  printError(Object error, StackTrace stackTrace) {
    debugPrint(error.toString());
    debugPrint(stackTrace.toString());
  }
}
