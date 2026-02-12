import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'inner_shadow.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color color;
  final BorderRadius? borderRadius;
  final Border? border;
  final bool isPill;

  const NeumorphicContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.color = AppColors.surfaceInput,
    this.borderRadius,
    this.border,
    this.isPill = false,
  });

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? BorderRadius.circular(isPill ? 66 : 16);
    
    if (isPill) {
       // Inner Shadow Style
       return InnerShadow(
         shadows: [
            Shadow(
             offset: const Offset(-1, -2),
             blurRadius: 4,
             color: AppColors.shadowLightStrong,
           ),
            const Shadow(
             offset: Offset(2, 3),
             blurRadius: 4,
             color: AppColors.shadowDark,
           ),
         ],
         child: Container(
           width: width,
           height: height,
           padding: padding,
           decoration: BoxDecoration(
             color: color,
             borderRadius: br,
             border: border ?? Border.all(color: AppColors.strokeDark, width: 2),
           ),
           child: child,
         ),
       );
    } else {
      // Outer Shadow Style (Standard Elevation)
      return Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: br,
          border: border ?? Border.all(color: AppColors.strokeDark, width: 2),
          boxShadow: const [
             BoxShadow(
              offset: Offset(2, 3),
              blurRadius: 4,
              color: AppColors.shadowDark,
            ),
            BoxShadow(
              offset: Offset(-1, -2),
              blurRadius: 4,
              color: AppColors.shadowLight,
            ),
          ],
        ),
        child: child,
      );
    }
  }
}
