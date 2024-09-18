// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konsi_test/app/core/common/constants/app_colors.dart';
import 'package:konsi_test/app/core/common/extensions/context_extension.dart';
import 'package:konsi_test/app/core/common/utils/toasting.dart';
import 'package:konsi_test/app/core/shared/dialogs/show_record_detail_modal.dart';
import 'package:konsi_test/app/core/shared/features/record/data/model/record_model.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/usecases/toggle_favorite.dart';
import 'package:konsi_test/app/modules/home/presentation/passbook/cubit/passbook_cubit.dart';
import 'package:konsi_test/app/ui/components/highlight_text.dart';

class RecordItem extends StatelessWidget {
  const RecordItem({super.key, required this.record, required this.searchedValue});
  final RecordModel record;
  final String searchedValue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        ShowRecordDetailModal(record: record).show(context);
      },
      title: HighlightText(
        text: record.address.cep,
        query: searchedValue,
        normalStyle: context.textTheme.bodyLarge,
        highlightStyle: context.textTheme.bodyLarge!.copyWith(color: AppColors.primary, fontSize: 21),
      ),
      subtitle: HighlightText(
        text: record.address.address,
        query: searchedValue,
        normalStyle: context.textTheme.bodySmall,
        highlightStyle: context.textTheme.bodySmall!.copyWith(color: AppColors.primary, fontSize: 17),
      ),
      trailing: _buildFavoritedIcon(context),
      shape: const Border(
        bottom: BorderSide(
          color: AppColors.grey_300,
        ),
      ),
    );
  }

  Widget _buildFavoritedIcon(BuildContext context) {
    Widget icon;
    if (record.favorited) {
      icon = const Icon(Icons.bookmark_rounded, color: AppColors.primary);
    } else {
      icon = const Icon(Icons.bookmark_outline_rounded, color: AppColors.grey_500);
    }
    return IconButton(
      onPressed: () async {
        await Modular.get<ToggleFavorite>()(ToggleFavoriteParams(recordId: record.id, value: !record.favorited)).then((value) async {
          if (value.isFailure) {
            Toasting.error(context, title: value.getFailure!.title, description: value.getFailure!.description);
            return;
          }
          await Modular.get<PassbookCubit>().getRecords();
        });
      },
      icon: icon,
      highlightColor: AppColors.primary.withOpacity(0.2),
    );
  }
}
