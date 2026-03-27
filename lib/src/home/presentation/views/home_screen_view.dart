import 'dart:async';

import 'package:e_commerce_app/core/common/views/loading_screen.dart';
import 'package:e_commerce_app/core/common/views/page_not_found.dart';
import 'package:e_commerce_app/core/common/widgets/filter_service.dart';
import 'package:e_commerce_app/src/cart/presentation/bloc/product_details_bloc.dart';
import 'package:e_commerce_app/src/product_details/presentation/views/product_details.dart';
import 'package:e_commerce_app/src/home/presentation/widgets/banner.dart';
import 'package:e_commerce_app/src/home/presentation/widgets/deals_banner.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/colors.dart';
import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:e_commerce_app/src/home/presentation/widgets/product_card_without_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late PageController pageController;
  Timer? timer;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    context.read<ProductDetailsBloc>().add(GetProductDetails());
    _startAutoScroll();
  }

  void _startAutoScroll() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (3 > 1) {
        if (currentPage < 3 - 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }

        if (pageController.hasClients) {
          pageController.animateToPage(
            currentPage,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic, // Smoother "Pro" curve
          );
        }
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        if (state is GettingProductDetailsState) {
          return LoadingScreen();
        }
        if (state is FetchedProductDetailsState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                // SizedBox(height: context.height * 0.015),
                // CustomSearchField(controller: TextEditingController()),
                SizedBox(height: context.height * 0.02),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: context.width * 0.4,
                        child: FittedBox(
                          child: Text(
                            context.localText.allFeaturedText,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: context.appColors.primaryTextColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: context.width * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTapDown: (details) =>
                                  FilterService.showSortMenu(context, details),
                              child: Container(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                width: context.width * 0.2,
                                height: context.height * 0.035,
                                decoration: BoxDecoration(
                                  color: context.appColors.bottomNavBg,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: context.appColors.primaryTextColor
                                          .withValues(alpha: 0.2),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        context.localText.sortText,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: context
                                              .appColors
                                              .primaryTextColor,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(
                                      Icons.swap_vert,
                                      size: 18,
                                      color: context.appColors.primaryTextColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTapDown: (details) =>
                                  FilterService.showFilterSheet(context),
                              child: Container(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                width: context.width * 0.22,
                                height: context.height * 0.035,
                                decoration: BoxDecoration(
                                  color: context.appColors.bottomNavBg,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: context.appColors.primaryTextColor
                                          .withValues(alpha: 0.2),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        context.localText.filterText,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: context
                                              .appColors
                                              .primaryTextColor,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(
                                      Icons.filter_alt_outlined,
                                      size: 18,
                                      color: context.appColors.primaryTextColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.height * 0.015),
                Container(
                  padding: EdgeInsets.only(left: 8, top: 8),
                  height: context.height * 0.12,
                  decoration: BoxDecoration(
                    color: context.appColors.contentContainerBgColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: context.appColors.primaryTextColor.withValues(
                          alpha: 0.04,
                        ),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 16);
                    },
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, PageNotFound.routeName);
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.all(
                                  Radius.circular(100),
                                ),
                                child: SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Image.asset(
                                    MediaResources.beautyProducts,

                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(context.localText.beautyText),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: context.height * 0.21,
                  child: PageView(
                    controller: pageController,
                    children: [PromoBanner(), PromoBanner(), PromoBanner()],
                  ),
                ),
                SizedBox(height: context.height * 0.015),
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  onDotClicked: (index) {
                    pageController.animateToPage(
                      index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  effect: WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: CustomColors.primaryColorLite,
                    spacing: 10,
                    dotColor: context.appColors.primaryTextColor,
                  ),
                ),
                DealsBanner(
                  backgroundColor: context.appColors.promotionalBannerBgColor,
                  title: context.localText.dealOfTheDayText,
                  subtitle: "22h 55m 20s ${context.localText.remainingText} ",
                  leadingIcon: Icons.alarm,
                  onTap: () {},
                ),

                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  height: context.height * 0.35,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.productDetails.length,
                    itemBuilder: (context, index) {
                      final product = state.productDetails[index];
                      return ProductCardWithoutReview(
                        productName: product.productName ?? "",
                        productDesc: product.description ?? "",
                        sellingPrice: product.sellingPrice!.toDouble(),
                        originalPrice: product.mrp!.toDouble(),
                        discountPercentage: product.discountPercentage ?? 0,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailsPage.routeName,
                            arguments: product,
                          );
                        },
                        imageUrl: product.productImages[0],
                        rating: product.averageRating,
                        reviewCount: product.ratingCount,
                        isNetworkImage: true,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 10);
                    },
                  ),
                ),
                DealsBanner(
                  backgroundColor: context.appColors.trendingBannerBgColor,
                  title: context.localText.trendingProductsText,
                  subtitle: "${context.localText.lastDateText} 05/04/26",
                  leadingIcon: Icons.calendar_month,
                  onTap: () {},
                ),

                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  height: context.height * 0.3,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.productDetails.length,
                    itemBuilder: (context, index) {
                      final product = state.productDetails[index];
                      return ProductCardWithoutReview(
                        productName: product.productName ?? "",
                        sellingPrice: product.sellingPrice!.toDouble(),
                        originalPrice: product.mrp!.toDouble(),
                        discountPercentage: product.discountPercentage ?? 0,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailsPage.routeName,
                            arguments: product,
                          );
                        },
                        imageUrl: product.productImages[2],
                        isNetworkImage: true,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 10);
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return LoadingScreen();
      },
    );
  }
}
