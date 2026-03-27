import 'dart:ui';

import 'package:e_commerce_app/core/extensions/app_colors_extension.dart';

class CustomColors {
  const CustomColors._();

  static final light = AppColorsExtension(
    primary: const Color(0XFFF83758),
    primaryLite: const Color(0XFFF5A2B0),
    scaffoldBg: const Color(0XFFF9F9F9),
    bottomNavBg: const Color(0XFFFFFFFF),
    primaryTextColor: const Color(0XFF000000),
    neutralText: const Color(0XFF757C8E),
    formFillTextColor: Color(0XFF626262),
    formFieldFillColor: Color(0XFFF3F3F3),
    smallContainerBgColor: Color(0XFFF2F2F2),
    contentContainerBgColor: Color(0XFFFFFFFF),
    promotionalBannerBgColor: Color(0xFF4392F9),
    trendingBannerBgColor: Color(0xFFFD6E87),
    addToCartBgColor: Color(0xFF2E4B8F),
    buyNowBgColor: Color(0xFF42D392),
    deliveryInfoBgColor: Color(0xFFFFD3E2),
    mainGradient: [
      Color(0XFFF83758),
      Color(0XFFFD6E87),
      Color(0xFFF8A4B5),
      Color(0xFFF8A4B5),
      Color(0XFFFD6E87),
      Color(0XFFF83758),
    ],
  );

  static final dark = AppColorsExtension(
    primary: const Color(0XFFF83758), // Keeping brand identity
    primaryLite: const Color.fromARGB(255, 100, 30, 45), // Muted dark pink
    scaffoldBg: const Color(0XFF121212),
    bottomNavBg: const Color(0XFF1E1E1E),
    primaryTextColor: const Color(0XFFE1E1E1),
    neutralText: const Color(0XFFBBBBBB), // Light grey for dark mode
    formFillTextColor: Color(0XFF9E9E9E),
    formFieldFillColor: Color(0XFF1E1E1E),
    smallContainerBgColor: Color(0XFF2A2A2A),
    contentContainerBgColor: Color(0XFF252525),
    promotionalBannerBgColor: Color(0XFF64A5FA),
    trendingBannerBgColor: Color(0XFFB85466),
    addToCartBgColor: Color(0XFF4A73C9),
    buyNowBgColor: Color(0XFF2D9A6C),
    deliveryInfoBgColor: Color(0XFF3D2129),
    mainGradient: [
      Color(0XFFF83758),
      Color(0XFFD64D65),
      Color(0xFF8A2436),
      Color(0xFF8A2436),
      Color(0XFFD64D65),
      Color(0XFFF83758),
    ], // Darker gradients
  );

  static const customGradientUnderConstruction = [
    Color(0XFFF83758),
    Color(0XFFFD6E87),
    Color.fromARGB(255, 248, 164, 181),
    Color.fromARGB(255, 241, 223, 223),
    Color(0XFFFD6E87),
    Color(0XFFF83758),
  ];

  static const primaryColor = Color(0XFFF83758);
  static const primaryColorLite = Color.fromARGB(255, 245, 162, 176);
  static const lightGreyColor = Color(0XFFF3F3F3);
  static const formFillTextColor = Color(0XFF626262);
  static const searchFillTextColor = Color(0XFFBBBBBB);
}
