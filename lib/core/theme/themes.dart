// ignore_for_file: non_constant_identifier_names

part of 'theme_config.dart';

mixin GharSubidhaTheme {
  static String CURRENT_THEME = "";
  // static ThemeData? _currentAppThemeData;
  static void initUiOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryDarkColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData.light(useMaterial3: false).copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        onSecondary: AppColors.secondaryTextColor,
      ),
      textTheme: GoogleFonts.latoTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData.dark(useMaterial3: true).copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        onPrimary: AppColors.primaryTextColor,
        onSecondary: AppColors.secondaryTextColor,
      ),
      textTheme: GoogleFonts.latoTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }

  static GharSubidhaTextTheme getTextTheme(context, {textColor}) {
    textColor ??= AppColors.black;

    if (CURRENT_THEME == APP_THEME_LIGHT) {
      return GharSubidhaTextTheme(
          bodySubTitle: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: fontBodySubTitle,
              fontWeight: FontWeight.normal,
              color: textColor),
          bodyTextSmall: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: fontBodyTextSmall,
              fontWeight: FontWeight.normal,
              color: textColor),
          bodyTextMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: fontBodyTextMedium,
              fontWeight: FontWeight.normal,
              color: textColor),
          bodyTextLarge: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: fontBodyTextLarge,
              fontWeight: FontWeight.normal,
              color: textColor),
          headingSubTitle: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: fontHeadingSubTitle,
              fontWeight: FontWeight.normal,
              color: textColor),
          headingSmall: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: fontHeadingSmall,
              fontWeight: FontWeight.normal,
              color: textColor),
          headingXSmall: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: fontHeadingXSmall,
              fontWeight: FontWeight.normal,
              color: textColor),
          headingMedium: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: fontHeadingMedium,
              fontWeight: FontWeight.normal,
              color: textColor),
          headingXMedium: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: fontHeadingXMedium,
              fontWeight: FontWeight.normal,
              color: textColor),
          headingLarge: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: fontHeadingLarge,
              fontWeight: FontWeight.normal,
              color: textColor));
    } else {
      return GharSubidhaTextTheme(
          bodySubTitle: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: fontBodySubTitle,
              fontWeight: FontWeight.normal,
              color: AppColors.charade),
          bodyTextSmall: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: fontBodyTextSmall,
              fontWeight: FontWeight.normal,
              color: AppColors.charade),
          bodyTextMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: fontBodyTextMedium,
              fontWeight: FontWeight.normal,
              color: AppColors.charade),
          bodyTextLarge: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: fontBodyTextLarge,
              fontWeight: FontWeight.normal,
              color: AppColors.charade),
          headingSubTitle: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: fontHeadingSubTitle,
              fontWeight: FontWeight.normal,
              color: AppColors.charade),
          headingSmall: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: fontHeadingSmall,
              fontWeight: FontWeight.normal,
              color: AppColors.charade),
          headingXSmall: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: fontHeadingXSmall,
              fontWeight: FontWeight.normal,
              color: AppColors.charade),
          headingMedium: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: fontHeadingMedium,
              fontWeight: FontWeight.normal,
              color: AppColors.charade),
          headingXMedium: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: fontHeadingXMedium,
              fontWeight: FontWeight.normal,
              color: AppColors.charade),
          headingLarge: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: fontHeadingLarge,
              fontWeight: FontWeight.normal,
              color: AppColors.charade));
    }
  }

  static SnackBarThemeData getSnackBarTheme() {
    return const SnackBarThemeData(
        backgroundColor: AppColors.coralRed,
        contentTextStyle:
            TextStyle(color: AppColors.mystic, fontWeight: FontWeight.bold));
  }

  static ElevatedButtonThemeData getElevatedButtonTheme(context,
      {backgroundColor, radius, fontSize}) {
    backgroundColor ??= AppColors.accent;
    radius ??= radiusX8;
    fontSize ??= fontBodyTextLarge;
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontSize: fontSize,
            ),
      ),
    );
  }
}
