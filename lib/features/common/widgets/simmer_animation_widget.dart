import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/app_colors.dart';

class SimmerAnimationWidget extends StatelessWidget {
  const SimmerAnimationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.themeColor.withAlpha(40),
      highlightColor: AppColors.themeColor.withAlpha(20),
      child: Container(
        color: AppColors.themeColor.withAlpha(50),
      ),
    );
  }
}