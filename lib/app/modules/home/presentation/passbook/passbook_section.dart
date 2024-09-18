import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:konsi_test/app/core/common/constants/app_assets.dart';
import 'package:konsi_test/app/core/common/extensions/context_extension.dart';
import 'package:konsi_test/app/core/common/extensions/widget/widget_extension.dart';
import 'package:konsi_test/app/core/common/utils/toasting.dart';
import 'package:konsi_test/app/modules/home/presentation/passbook/cubit/passbook_cubit.dart';
import 'package:konsi_test/app/ui/components/final_list_indicator.dart';
import 'package:konsi_test/app/ui/components/input_search.dart';
import 'package:konsi_test/app/ui/components/itens/record_item.dart';
import 'package:konsi_test/app/ui/components/loader.dart';
import 'package:konsi_test/app/ui/components/refresh_page.dart';

class PassbookSection extends StatefulWidget {
  const PassbookSection({super.key});

  @override
  State<PassbookSection> createState() => _PassbookSectionState();
}

class _PassbookSectionState extends State<PassbookSection> {
  PassbookCubit cubit = Modular.get();
  @override
  void initState() {
    cubit.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchInput(),
        BlocConsumer<PassbookCubit, PassbookState>(
          bloc: cubit,
          listener: (context, state) {
            if (state is PassbookError) {
              Toasting.error(context, title: state.title, description: state.description);
            }
          },
          builder: (context, state) {
            if (state is PassbookSearched) {
              if (cubit.viwedRecords.isEmpty) {
                return _buildNoRecodsFound();
              }
              return RefreshPage(
                onRefresh: cubit.getRecords,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    if (index == cubit.viwedRecords.length) {
                      return const FinalListIndicator();
                    }
                    return RecordItem(record: cubit.viwedRecords[index], searchedValue: cubit.searchController.text);
                  },
                  itemCount: cubit.viwedRecords.length + 1,
                ),
              );
            }
            if (state is PassbookSearching) {
              return const Center(
                child: Loader(),
              );
            }
            return const Center(child: Text('Caderneta'));
          },
        ).pH(14).expanded(),
      ],
    );
  }

  Widget _buildSearchInput() {
    return Container(
      color: context.colorScheme.primaryContainer,
      child: SafeArea(
        child: InputSearch(
          cubit.searchController,
          searchAction: (_) async {
            await cubit.getRecords();
          },
        ).p(14),
      ),
    );
  }

  Widget _buildNoRecodsFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppAssets.svgs.no_records,
          width: 100,
        ),
        const Gap(16),
        Text(
          'Nenhum registro encontrado na\nsua caderneta!',
          style: context.textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
      ],
    ).pH(24);
  }
}
