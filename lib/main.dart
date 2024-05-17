import 'dart:async';
import 'config/configuration.dart';
import 'global/app_start_widget.dart';
import 'package:flutter/material.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';

void main() => Main();

class Main extends Env {
  @override
  FutureOr<Widget> onCreate() {
    ErrorWidget.builder = (details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return const ColoredBox(color: AppColors.primaryColor);
    };
    return const AppStartWidget();
  }
}
