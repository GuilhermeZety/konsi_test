import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konsi_test/app/core/shared/features/locale/locale_logic.dart';
import 'package:konsi_test/app/modules/home/presentation/home_page.dart';
import 'package:konsi_test/app/modules/home/presentation/maps/cubit/maps_section_cubit.dart';
import 'package:konsi_test/app/modules/home/presentation/passbook/cubit/passbook_cubit.dart';
import 'package:konsi_test/app/ui/components/map/cubit/maps_cubit.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<PassbookCubit>(() => PassbookCubit());
    i.addSingleton<MapsCubit>(() => MapsCubit());
    i.addSingleton<MapsSectionCubit>(() => MapsSectionCubit());
    LocaleLogic.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (args) => const HomePage(),
      transition: TransitionType.fadeIn,
      duration: 500.ms,
    );
  }
}
