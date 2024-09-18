import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konsi_test/app/core/common/constants/app_assets.dart';
import 'package:konsi_test/app/core/common/constants/app_colors.dart';
import 'package:konsi_test/app/core/common/constants/app_routes.dart';
import 'package:konsi_test/app/core/common/extensions/widget/widget_extension.dart';
import 'package:konsi_test/app/core/common/utils/toasting.dart';
import 'package:konsi_test/app/modules/splash/presentation/cubit/splash_page_cubit.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashPageCubit cubit = SplashPageCubit();

  @override
  void initState() {
    cubit.initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: BlocListener<SplashPageCubit, SplashPageState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is SplashPageError) {
            Toasting.error(context, title: state.title, description: state.description);
          }
          if (state is SplashPageNoHasConnection) {
            Toasting.noConnection(context);
            Modular.to.pushNamedAndRemoveUntil(AppRoutes.notConnection, (_) => false);
          }
          if (state is SplashPageSuccess) {
            Modular.to.pushNamedAndRemoveUntil('/home/', (_) => false);
          }
        },
        child: Center(
          child: SizedBox(
            width: 150,
            height: 150,
            child: Lottie.asset(
              AppAssets.lotties.splash_animation,
              width: 150,
              fit: BoxFit.cover,
              height: 150,
              animate: true,
            ),
          ).hero('logo'),
        ),
      ),
    );
  }
}
