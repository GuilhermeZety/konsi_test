import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:konsi_test/app/core/common/constants/app_assets.dart';
import 'package:konsi_test/app/core/common/constants/app_fonts.dart';
import 'package:konsi_test/app/core/common/constants/app_routes.dart';
import 'package:konsi_test/app/core/common/extensions/context_extension.dart';
import 'package:konsi_test/app/core/common/extensions/widget/widget_extension.dart';
import 'package:konsi_test/app/ui/components/button.dart';
import 'package:lottie/lottie.dart';

class NotConnectedPage extends StatefulWidget {
  const NotConnectedPage({super.key});

  @override
  State<NotConnectedPage> createState() => _NotConnectedPageState();
}

class _NotConnectedPageState extends State<NotConnectedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        height: context.height,
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Lottie.asset(
                    AppAssets.lotties.splash_animation,
                    width: 200,
                    fit: BoxFit.cover,
                    height: 200,
                    animate: false,
                  ),
                ).hero('logo'),
                const Gap(50),
                Text(
                  'Ops!',
                  style: TextStyle(
                    color: context.textTheme.titleLarge!.color,
                    fontSize: 24,
                    fontWeight: AppFonts.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  'Parece que você está sem conexão com a internet. \n\nVerifique sua conexão e tente novamente.',
                  style: context.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ).expanded(),
            Button(
              onPressed: () async => Modular.to.pushNamedAndRemoveUntil(
                AppRoutes.splash,
                (_) => false,
              ),
              child: const Text('Tentar novamente'),
            ).expandedH(),
          ],
        ),
      ),
    );
  }
}
