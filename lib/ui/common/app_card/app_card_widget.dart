import 'package:flutter/material.dart';

import '../../../../resources/colors/app_colors.dart';
import '../../../../resources/dimens/app_dimens.dart';

class AppCardWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final bool clipContent;

  const AppCardWidget({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 4,
    ),
    this.padding = const EdgeInsets.all(
      12,
    ),
    this.clipContent = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Card(
      margin: margin,
      elevation: 0,
      color: AppColors.primaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimens.radiusMd,
        ),
      ),
      clipBehavior: clipContent ? Clip.antiAlias : Clip.none,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
