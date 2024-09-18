// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:konsi_test/app/core/common/constants/app_colors.dart';
import 'package:konsi_test/app/core/common/constants/app_fonts.dart';
import 'package:konsi_test/app/core/common/extensions/widget/widget_extension.dart';
import 'package:konsi_test/app/core/common/utils/custom_dialog_utils.dart';
import 'package:konsi_test/app/core/common/utils/toasting.dart';
import 'package:konsi_test/app/core/shared/features/record/data/model/record_model.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/usecases/toggle_favorite.dart';
import 'package:konsi_test/app/modules/home/presentation/passbook/cubit/passbook_cubit.dart';
import 'package:konsi_test/app/ui/components/button.dart';
import 'package:konsi_test/app/ui/components/custom_dialog.dart';
import 'package:konsi_test/app/ui/components/panel.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowRecordDetailModal extends StatefulWidget {
  const ShowRecordDetailModal({
    super.key,
    required this.record,
  });

  final RecordModel record;
  Future show(
    BuildContext context,
  ) async {
    return showCustomDialog(
      context,
      child: this,
    );
  }

  @override
  State<ShowRecordDetailModal> createState() => _ShowRecordDetailModalState();
}

class _ShowRecordDetailModalState extends State<ShowRecordDetailModal> {
  late RecordModel record;
  TextEditingController controller = TextEditingController();
  PassbookCubit cubit = Modular.get();

  @override
  void initState() {
    record = widget.record;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      top: Row(
        children: [
          const Text(
            'Registro',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: AppFonts.bold,
            ),
          ),
          const Spacer(),
          _buildToMapsIcon(),
          _buildFavoritedIcon(),
        ],
      ),
      bottom: Button.outlined(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Fechar'),
      ).expandedH(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Panel(
              border: Border.all(
                color: AppColors.grey_200,
                width: 1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildValue('CEP', record.address.cep),
                  const Gap(4),
                  _buildValue('Endereço', record.address.address),
                  const Gap(4),
                  _buildValue('Número', record.address.number ?? 'Sem numeração'),
                  const Gap(4),
                  _buildValue('Complemento', record.address.complement ?? ''),
                ],
              ),
            ).expandedH(),
          ],
        ),
      ),
    );
  }

  Widget _buildValue(String title, String value) {
    return Text.rich(
      TextSpan(
        text: '$title: ',
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              fontWeight: AppFonts.bold,
              color: AppColors.grey_800,
              fontSize: 16,
            ),
          ),
        ],
        style: const TextStyle(
          fontWeight: AppFonts.normal,
          color: AppColors.grey_500,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildFavoritedIcon() {
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
          await cubit.getRecords();
          var newRecord = cubit.viwedRecords.where((element) => element.id == record.id).firstOrNull;
          if (newRecord == null) {
            Modular.to.pop();
            return;
          }
          record = newRecord;
          if (mounted) setState(() {});
        });
      },
      icon: icon,
      highlightColor: AppColors.primary.withOpacity(0.2),
    );
  }

  Widget _buildToMapsIcon() {
    return IconButton(
      onPressed: () async {
        //to maps with address and number and complement if have
        launchUrl(
          Uri.parse('https://www.google.com/maps/search/?api=1&query=${record.address.address}+${record.address.number ?? ''}+${record.address.complement ?? ''}'),
          mode: LaunchMode.externalApplication,
        );
      },
      icon: const Icon(Icons.map_rounded, color: AppColors.primary),
    );
  }
}
