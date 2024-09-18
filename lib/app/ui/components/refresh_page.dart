import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:konsi_test/app/core/common/constants/app_colors.dart';

class RefreshPageColors {
  final Color content;
  final Color background;

  const RefreshPageColors({
    required this.content,
    required this.background,
  });
}

class RefreshPageStyle {
  final RefreshPageColors loading;
  final RefreshPageColors completed;

  const RefreshPageStyle({
    required this.loading,
    required this.completed,
  });
}

class RefreshPage extends StatefulWidget {
  final Widget child;
  final IndicatorController? controller;
  final GlobalKey<CustomRefreshIndicatorState>? indicatorKey;
  final double? displacement;
  final Future<void> Function() onRefresh;

  const RefreshPage({
    super.key,
    required this.child,
    required this.onRefresh,
    this.displacement,
    this.controller,
    this.indicatorKey,
  });

  @override
  State<RefreshPage> createState() => _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> with SingleTickerProviderStateMixin {
  /// Whether to render check mark instead of spinner
  bool _renderCompleteState = false;

  ScrollDirection prevScrollDirection = ScrollDirection.idle;
  var refreshStyle = const RefreshPageStyle(
    loading: RefreshPageColors(content: AppColors.primary, background: Colors.white),
    completed: RefreshPageColors(
      content: Colors.white,
      background: AppColors.primary,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
      key: widget.indicatorKey,
      onRefresh: widget.onRefresh,
      controller: widget.controller,
      displacement: widget.displacement ?? 40,
      durations: const RefreshIndicatorDurations(
        completeDuration: Duration(seconds: 1),
      ),
      onStateChanged: (change) {
        /// set [_renderCompleteState] to true when controller.state become completed
        if (change.didChange(to: IndicatorState.complete)) {
          _renderCompleteState = true;

          /// set [_renderCompleteState] to false when controller.state become idle
        } else if (change.didChange(to: IndicatorState.idle)) {
          _renderCompleteState = false;
        }
      },
      indicatorBuilder: (
        BuildContext context,
        IndicatorController controller,
      ) {
        final style = _renderCompleteState ? refreshStyle.completed : refreshStyle.loading;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: style.background,
            shape: BoxShape.circle,
          ),
          child: _renderCompleteState
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: style.content,
                    value: controller.isDragging || controller.isArmed ? controller.value.clamp(0.0, 1.0) : null,
                  ),
                ),
        );
      },
      child: widget.child,
    );
  }
}
