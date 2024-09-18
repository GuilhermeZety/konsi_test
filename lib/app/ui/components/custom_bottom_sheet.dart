import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:konsi_test/app/core/common/constants/app_colors.dart';
import 'package:konsi_test/app/core/common/extensions/context_extension.dart';
import 'package:konsi_test/app/core/common/extensions/widget/widget_extension.dart';
import 'package:konsi_test/app/ui/components/panel.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key, this.backgroundColor, required this.child, this.onClose, required this.childHeight, this.heroTag});

  final Color? backgroundColor;
  final Widget child;
  final double childHeight;
  final Function? onClose;
  final String? heroTag;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  late double originalHeight;
  late double _sheetHeight; // Altura inicial do Container

  @override
  void initState() {
    originalHeight = widget.childHeight + 52;
    _sheetHeight = originalHeight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          _sheetHeight -= details.primaryDelta!;
          if (_sheetHeight < 100.0) {
            _sheetHeight = 100.0;
          }
        });
      },
      onVerticalDragEnd: (details) async {
        if (_sheetHeight < (originalHeight / 3) * 2.5) {
          _sheetHeight = 60;
          if (mounted) setState(() {});
          Future.delayed(100.ms, () => widget.onClose?.call());
        } else {
          _sheetHeight = originalHeight;
          if (mounted) setState(() {});
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: _sheetHeight,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: Panel(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          radius: const BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
          withShadow: true,
          color: widget.backgroundColor ?? context.colorScheme.secondaryContainer,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.grey_600.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(100),
                ),
                width: 32,
                height: 4,
              ).pBottom(16),
              widget.child.expanded(),
            ],
          ),
        ),
      ).hero(widget.heroTag),
    );
  }
}
