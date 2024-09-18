import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:konsi_test/app/core/common/extensions/context_extension.dart';
import 'package:konsi_test/app/core/common/extensions/widget/widget_extension.dart';
import 'package:konsi_test/app/core/common/utils/toasting.dart';
import 'package:konsi_test/app/modules/home/presentation/maps/cubit/maps_section_cubit.dart';
import 'package:konsi_test/app/ui/components/input_search.dart';
import 'package:konsi_test/app/ui/components/itens/locale_item.dart';
import 'package:konsi_test/app/ui/components/map/map_container.dart';
import 'package:konsi_test/app/ui/components/panel.dart';

class MapsSection extends StatefulWidget {
  const MapsSection({super.key});

  @override
  State<MapsSection> createState() => _MapsSectionState();
}

class _MapsSectionState extends State<MapsSection> {
  final cubit = Modular.get<MapsSectionCubit>();
  //
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapsSectionCubit, MapsSectionState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is MapsSectionError) {
          Toasting.error(
            context,
            title: state.title,
            description: state.description,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            const Positioned.fill(
              child: MapContainer(),
            ),
            _buildSearchResults(),
            _buildSearchButton(),
          ],
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return Positioned.fill(
      child: Column(
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: Column(
              children: [
                Panel(
                  width: context.width,
                  radius: BorderRadius.circular(20),
                  padding: EdgeInsets.zero,
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (cubit.searchController.text.isNotEmpty && cubit.selected == null) ...[
                            if (cubit.locales.isNotEmpty) ...[
                              Container(
                                color: context.colorScheme.secondaryContainer,
                                height: 90 + context.safeArea(AxisDirection.up),
                              ),
                              ...cubit.locales.map(
                                (e) => LocaleItem(
                                  address: e,
                                  searchedValue: cubit.searchController.text,
                                  onSelect: () => cubit.select(e),
                                ).pH(12),
                              ),
                              const Gap(20),
                            ] else ...[
                              Container(
                                color: context.colorScheme.secondaryContainer,
                                height: 90 + context.safeArea(AxisDirection.up),
                              ),
                              const Text('Nenhum resultado encontrado'),
                              const Gap(20),
                            ],
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton() {
    return Positioned(
      right: 14,
      top: 14,
      left: 14,
      child: SafeArea(
        child: InputSearch(
          cubit.searchController,
          searchAction: cubit.search,
          keyboard: TextInputType.number,
          formatter: [
            FilteringTextInputFormatter.digitsOnly,
            TextInputMask(
              mask: '99999-999',
            ),
          ],
        ),
      ),
    );
  }
}
