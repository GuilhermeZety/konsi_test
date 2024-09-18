import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:konsi_test/app/core/common/extensions/context_extension.dart';
import 'package:konsi_test/app/core/common/extensions/widget/widget_extension.dart';
import 'package:konsi_test/app/core/shared/models/address_model.dart';
import 'package:konsi_test/app/ui/components/button.dart';
import 'package:konsi_test/app/ui/components/custom_bottom_sheet.dart';

class SelectedLocaleBottomSheet extends StatelessWidget {
  const SelectedLocaleBottomSheet({super.key, required this.locale, required this.onClose, required this.onConfirm, this.heroTag});

  final AddressModel locale;
  final Function onClose;
  final Future Function() onConfirm;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      childHeight: 200,
      onClose: onClose,
      heroTag: heroTag,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(24),
            Text(
              locale.cep,
              style: context.textTheme.titleMedium,
            ).expandedH(),
            const Gap(16),
            Text(
              locale.address,
              style: context.textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ).expandedH(),
            const Gap(24),
            Button(
              onPressed: onConfirm,
              child: const Text(
                'Salvar Endereço',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
