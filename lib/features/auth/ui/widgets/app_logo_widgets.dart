import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return SvgPicture.asset(AssetsPath.appLogoSvg,height: logoHeight??100,width: logoWidth??100,fit: boxFit ?? BoxFit.scaleDown,);
  }
}
