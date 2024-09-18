import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konsi_test/app/core/common/utils/overlay_ui_utils.dart';
import 'package:konsi_test/app/core/shared/app_theme.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    OverlayUIUtils.setOverlayStyle(barDark: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Konsi',
      theme: AppTheme.light,
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
