import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color primary;
  final Color primaryLite;
  final Color scaffoldBg;
  final Color bottomNavBg;
  final Color neutralText;
  final Color primaryTextColor;
  final Color formFillTextColor;
  final Color formFieldFillColor;
  final Color smallContainerBgColor;
  final Color contentContainerBgColor;
  final Color promotionalBannerBgColor;
  final Color trendingBannerBgColor;
  final Color addToCartBgColor;
  final Color buyNowBgColor;
  final Color deliveryInfoBgColor;

  final List<Color> mainGradient;
  // Add any other specific colors you use often here...

  const AppColorsExtension({
    required this.primary,
    required this.primaryLite,
    required this.scaffoldBg,
    required this.bottomNavBg,
    required this.neutralText,
    required this.primaryTextColor,
    required this.formFillTextColor,
    required this.formFieldFillColor,
    required this.smallContainerBgColor,
    required this.mainGradient,
    required this.contentContainerBgColor,
    required this.promotionalBannerBgColor,
    required this.trendingBannerBgColor,
    required this.addToCartBgColor,
    required this.buyNowBgColor,
    required this.deliveryInfoBgColor,
  });

  @override
  ThemeExtension<AppColorsExtension> copyWith() => this;

  @override
  ThemeExtension<AppColorsExtension> lerp(
    ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryLite: Color.lerp(primaryLite, other.primaryLite, t)!,
      scaffoldBg: Color.lerp(scaffoldBg, other.scaffoldBg, t)!,
      bottomNavBg: Color.lerp(bottomNavBg, other.bottomNavBg, t)!,
      primaryTextColor: Color.lerp(
        primaryTextColor,
        other.primaryTextColor,
        t,
      )!,
      neutralText: Color.lerp(neutralText, other.neutralText, t)!,
      formFillTextColor: Color.lerp(
        formFillTextColor,
        other.formFillTextColor,
        t,
      )!,
      smallContainerBgColor: Color.lerp(
        smallContainerBgColor,
        other.smallContainerBgColor,
        t,
      )!,
      formFieldFillColor: Color.lerp(
        formFieldFillColor,
        other.formFieldFillColor,
        t,
      )!,
      contentContainerBgColor: Color.lerp(
        contentContainerBgColor,
        other.contentContainerBgColor,
        t,
      )!,
      promotionalBannerBgColor: Color.lerp(
        promotionalBannerBgColor,
        other.promotionalBannerBgColor,
        t,
      )!,
      trendingBannerBgColor: Color.lerp(
        trendingBannerBgColor,
        other.trendingBannerBgColor,
        t,
      )!,
      addToCartBgColor: Color.lerp(
        addToCartBgColor,
        other.addToCartBgColor,
        t,
      )!,
      buyNowBgColor: Color.lerp(buyNowBgColor, other.buyNowBgColor, t)!,
      deliveryInfoBgColor: Color.lerp(
        deliveryInfoBgColor,
        other.deliveryInfoBgColor,
        t,
      )!,
      mainGradient:
          mainGradient, // Gradients are harder to lerp, keeping static for now
    );
  }
}
