import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konsi_test/app/core/common/constants/app_routes.dart';
import 'package:konsi_test/app/core/shared/services/connection/connection_service.dart';
import 'package:konsi_test/app/modules/home/presentation/components/selected_locale_bottom_sheet.dart';
import 'package:konsi_test/app/modules/home/presentation/maps/cubit/maps_section_cubit.dart';
import 'package:konsi_test/app/modules/home/presentation/maps/maps_section.dart';
import 'package:konsi_test/app/modules/home/presentation/passbook/passbook_section.dart';
import 'package:konsi_test/app/ui/components/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController navController = PageController();
  MapsSectionCubit cubit = Modular.get();
  int index = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var hasConnection = await Modular.get<ConnectionService>().isConnected;

      if (!hasConnection) {
        onSelectDestination(1);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: NavBar(
          index: index,
          onDestinationSelected: onSelectDestination,
        ),
        bottomSheet: BlocBuilder(
          bloc: cubit,
          builder: (context, state) {
            if (cubit.selected == null) {
              return const SizedBox();
            }
            return SelectedLocaleBottomSheet(
              locale: cubit.selected!,
              onClose: cubit.removeSelected,
              heroTag: 'hero-review-record',
              onConfirm: () async {
                var created = await Modular.to.pushNamed(AppRoutes.reviewRecord, arguments: cubit.selected!);
                if (created == true) {
                  cubit.clear();
                  navController.animateToPage(1, duration: 300.ms, curve: Curves.easeInOut);
                }
              },
            );
          },
        ),
        resizeToAvoidBottomInset: false,
        body: PageView(
          controller: navController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            index = value;
            if (mounted) setState(() {});
          },
          children: const [
            MapsSection(),
            PassbookSection(),
          ],
        ),
      ),
    );
  }

  void onSelectDestination(int index) {
    index = index;
    if (mounted) setState(() {});
    navController.animateToPage(index, duration: 300.ms, curve: Curves.easeInOut);
  }
}
