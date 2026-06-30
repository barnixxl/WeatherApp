import 'package:flutter/material.dart';

import '../../../../resources/colors/app_colors.dart';

class AppCardWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double? height;
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
    this.height,
    this.clipContent = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: margin,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(
          16,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(
              alpha: 0.3,
            ),
            blurRadius: 4,
            offset: const Offset(
              0,
              2,
            ),
          ),
        ],
      ),
      child: clipContent
          ? ClipRRect(
              borderRadius: BorderRadius.circular(
                16,
              ),
              child: child,
            )
          : Padding(
              padding: padding,
              child: child,
            ),
    );
  }
}
