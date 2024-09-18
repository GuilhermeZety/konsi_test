import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:konsi_test/app/core/common/constants/app_colors.dart';
import 'package:konsi_test/app/core/common/extensions/context_extension.dart';
import 'package:konsi_test/app/core/common/extensions/widget/widget_extension.dart';
import 'package:konsi_test/app/core/common/utils/custom_dialog_utils.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
    this.showBackButton = true,
    this.onBack,
    this.backText,
    required this.child,
    this.bottom,
    this.top,
    this.topSize = 30,
    this.bottomSize = 30,
    this.dimissAction,
    this.backgroundColor,
  });

  final bool showBackButton;
  final String? backText;
  final Function()? onBack;
  final Widget child;
  final Widget? bottom;
  final double bottomSize;
  final Widget? top;
  final double topSize;
  final Color? backgroundColor;
  final Function()? dimissAction;

  @override
  State<CustomDialog> createState() => _CustomDialogState();

  Future<T?> show<T>(BuildContext context) {
    return showCustomDialog<T>(context, child: this);
  }
}

class _CustomDialogState extends State<CustomDialog> {
  Widget _content(BuildContext context) => GestureDetector(
        onTap: () {
          if (widget.dimissAction != null) {
            widget.dimissAction!();
          } else {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          }
        },
        child: Container(
          height: context.height,
          width: context.width,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.backgroundColor ?? context.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.top != null) ...[
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.grey_600.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          width: 32,
                          height: 4,
                        ).pV(16),
                        Container(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                            left: 30,
                            right: 30,
                          ),
                          alignment: Alignment.center,
                          child: widget.top!,
                        ).expandedH(),
                      ],
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 30,
                              right: 30,
                            ),
                            decoration: const BoxDecoration(),
                            constraints: BoxConstraints(
                              maxHeight: (context.height * 0.9) - (widget.bottom != null ? widget.bottomSize : 0) - (widget.top != null ? widget.topSize : 0),
                            ),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: widget.child,
                            ),
                          ),
                        ),
                      ),
                      if (widget.bottom != null)
                        Container(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                            left: 30,
                            right: 30,
                            top: 10,
                          ),
                          child: widget.bottom!,
                        ),
                      Gap(context.safeArea(AxisDirection.down)),
                    ],
                  ),
                ),
              ),
              Gap(MediaQuery.viewInsetsOf(context).bottom),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return _content(context);
  }
}
