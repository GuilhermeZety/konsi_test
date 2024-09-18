// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:konsi_test/app/core/common/constants/app_colors.dart';
import 'package:konsi_test/app/core/common/extensions/context_extension.dart';
import 'package:konsi_test/app/core/shared/models/address_model.dart';

class LocaleItem extends StatelessWidget {
  const LocaleItem({
    super.key,
    required this.address,
    required this.searchedValue,
    required this.onSelect,
  });
  final AddressModel address;
  final String searchedValue;
  final Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onSelect,
      title: Text(
        address.cep,
        style: context.textTheme.bodyLarge,
      ),
      subtitle: Text(
        address.address,
        style: context.textTheme.bodySmall,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      leading: const Icon(Icons.location_on, color: AppColors.primary),
      // trailing: _buildFavoritedIcon(context),
      shape: const Border(
        bottom: BorderSide(
          color: AppColors.grey_300,
        ),
      ),
    );
  }
}
