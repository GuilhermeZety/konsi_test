import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:konsi_test/app/core/common/constants/app_colors.dart';
import 'package:konsi_test/app/core/common/constants/app_fonts.dart';
import 'package:konsi_test/app/core/common/extensions/context_extension.dart';
import 'package:konsi_test/app/ui/components/loader.dart';

class InputSearch extends StatefulWidget {
  final String? label;
  final TextInputType keyboard;
  final TextEditingController controller;
  final String? Function(String?)? validation;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter>? formatter;
  final String? hint;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final bool showError;
  final Function(String?)? onChange;
  final Future<void> Function(String?) searchAction;
  final Function()? onTap;
  final FocusNode? focusNode;
  final Color? fillColor;

  const InputSearch(
    this.controller, {
    super.key,
    this.label,
    required this.searchAction,
    this.keyboard = TextInputType.text,
    this.formatter,
    this.validation,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.hint,
    this.minLines,
    this.maxLines,
    this.readOnly = false,
    this.showError = true,
    this.onTap,
    this.onChange,
    this.focusNode,
    this.fillColor,
  });

  const InputSearch.numeric(
    this.controller, {
    super.key,
    this.label,
    required this.searchAction,
    this.keyboard = TextInputType.number,
    this.formatter,
    this.validation,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.hint,
    this.minLines,
    this.maxLines,
    this.readOnly = false,
    this.showError = true,
    this.onTap,
    this.onChange,
    this.focusNode,
    this.fillColor,
  });
  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  bool visible = false;

  Timer? searchTimer;

  void search() async {
    searchTimer?.cancel();

    if (mounted) setState(() {});
    searchTimer = Timer(const Duration(milliseconds: 300), () async {
      await widget.searchAction(widget.controller.text);
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey_500.withOpacity(0.32),
                blurRadius: 7,
                offset: const Offset(1, 4),
              ),
            ],
          ),
          child: TextFormField(
            key: widget.key,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            controller: widget.controller,
            autovalidateMode: widget.autovalidateMode,
            validator: widget.validation,
            inputFormatters: widget.formatter,
            keyboardType: widget.keyboard,
            minLines: widget.minLines,
            maxLines: widget.maxLines ?? 1,
            readOnly: widget.readOnly,
            obscureText: widget.keyboard == TextInputType.visiblePassword ? !visible : false,
            onChanged: (value) {
              widget.onChange?.call(value);
              search();
            },
            onTap: widget.onTap,
            focusNode: widget.focusNode,
            style: const TextStyle(
              color: AppColors.grey_900,
              fontSize: 20,
              fontWeight: AppFonts.semiBold,
            ),
            decoration: InputDecoration(
              filled: true,
              // label: Text(widget.label ?? 'Buscar'),

              fillColor: widget.fillColor ?? AppColors.grey_200,
              errorMaxLines: 2,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.grey_500,
              ),
              hintStyle: context.theme.inputDecorationTheme.hintStyle?.copyWith(),
              hintText: widget.hint ?? 'Buscar',
              suffixIcon: searchTimer?.isActive == true
                  ? const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Loader(
                          size: 20,
                        ),
                      ],
                    )
                  : widget.controller.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            widget.controller.clear();
                            widget.searchAction('');
                          },
                          child: Icon(
                            Icons.cancel,
                            color: context.textTheme.displayMedium?.color,
                            size: 20,
                          ),
                        )
                      : const Gap(0),
              suffixIconColor: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
