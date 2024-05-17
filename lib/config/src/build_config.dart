import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../core/utils/logging.dart';

enum Flavor { development, staging, release }

class BuildConfig {
  const BuildConfig._({
    required this.baseUrl,
    required this.socketUrl,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.flavor,
  });

  const BuildConfig._development()
      : this._(
          baseUrl: 'debug url',
          socketUrl: '',
          connectTimeout: const Duration(milliseconds: 20000),
          receiveTimeout: const Duration(milliseconds: 20000),
          flavor: Flavor.development,
        );
  const BuildConfig._staging()
      : this._(
          baseUrl: 'staging url',
          socketUrl: '',
          connectTimeout: const Duration(milliseconds: 20000),
          receiveTimeout: const Duration(milliseconds: 20000),
          flavor: Flavor.development,
        );
  const BuildConfig._release()
      : this._(
          baseUrl: 'release url',
          socketUrl: '',
          connectTimeout: const Duration(milliseconds: 20000),
          receiveTimeout: const Duration(milliseconds: 20000),
          flavor: Flavor.development,
        );
  static late BuildConfig _buildInstance;

  static void init({String? flavor}) {
    debugPrint(
        '╔══════════════════════════════════════════════════════════════╗');
    debugPrint(
        '                    Build Flavor: $flavor                       ');
    debugPrint(
        '╚══════════════════════════════════════════════════════════════╝');

    switch (flavor) {
      case 'development':
        _buildInstance = const BuildConfig._development();
      case 'staging':
        _buildInstance = const BuildConfig._staging();
      default:
        _buildInstance = const BuildConfig._release();
    }
    unawaited(_initLog());
  }

  static BuildConfig get() {
    return _buildInstance;
  }

  static Future<void>? _initLog() async {
    await Log.init();
    switch (_buildInstance.flavor) {
      case Flavor.development:
      case Flavor.staging:
        Log.setLevel(Level.ALL);
      case Flavor.release:
        Log.setLevel(Level.OFF);
    }
  }

  final String baseUrl;
  final String socketUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Flavor flavor;

  static String get flavorName => _buildInstance.flavor.name;

  static bool get isProduction => _buildInstance.flavor == Flavor.release;

  static bool get isStaging => _buildInstance.flavor == Flavor.staging;

  static bool get isDevelopment => _buildInstance.flavor == Flavor.development;
}
