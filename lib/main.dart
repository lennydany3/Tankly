import 'package:flutter/material.dart';

import 'package:tankly/app/gallery.dart';
import 'package:tankly/app/tankly_shell.dart';
import 'package:tankly/screens/onboarding/onboarding_screens.dart';
import 'package:tankly/theme/tankly_theme.dart';

void main() => runApp(const TanklyApp());

class TanklyApp extends StatelessWidget {
  const TanklyApp({super.key, this.startAtGallery = false, this.light = false});

  /// Design review entry point. Not wired into the shipped navigation.
  final bool startAtGallery;
  final bool light;

  @override
  Widget build(BuildContext context) {
    // `flutter run --dart-define=TANKLY_GALLERY=true` opens the gallery on a
    // device, which is the only way to review both themes on real glass.
    const fromDefine = bool.fromEnvironment('TANKLY_GALLERY');
    const lightFromDefine = bool.fromEnvironment('TANKLY_LIGHT');

    return MaterialApp(
      title: 'Tankly',
      debugShowCheckedModeBanner: false,
      theme: TanklyTheme.light,
      darkTheme: TanklyTheme.dark,
      themeMode: (light || lightFromDefine) ? ThemeMode.light : ThemeMode.dark,
      home: (startAtGallery || fromDefine)
          ? const DesignGallery()
          : const TanklyShell(),
    );
  }
}

/// Cold start, shown while the database opens and the session is checked.
class TanklyLaunch extends StatelessWidget {
  const TanklyLaunch({super.key});

  @override
  Widget build(BuildContext context) => const SplashScreen();
}
