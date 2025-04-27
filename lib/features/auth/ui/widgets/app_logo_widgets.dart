import 'package:flutter/material.dart';

import '../../../../app/assets_path.dart' show AssetsPath;

class AppLogoWidget extends StatelessWidget {
  final double? logoHeight;
  final double? logoWidth;
  final BoxFit? boxFit;

  const AppLogoWidget({
    super.key, this.logoHeight, this.logoWidth, this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(AssetsPath.appLogoPng,height: logoHeight??100,width: logoWidth??100,fit: boxFit ?? BoxFit.scaleDown,);
  }
}
