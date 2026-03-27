import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/common/views/main_dashboard_screen.dart';
import 'package:e_commerce_app/core/common/widgets/filter_service.dart';
import 'package:e_commerce_app/core/common/widgets/modern_toast.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:e_commerce_app/core/services/injection_container.dart';
import 'package:e_commerce_app/core/services/razorpay_services.dart';
import 'package:e_commerce_app/src/cart/data/cart_manager.dart';
import 'package:e_commerce_app/src/cart/data/model/cart_item_model.dart';
import 'package:e_commerce_app/src/cart/data/model/product_details_model.dart';
import 'package:e_commerce_app/src/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce_app/src/home/presentation/widgets/product_list_with_reviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({required this.productDetails, super.key});

  static const routeName = '/product-details';
  final ProductDetailsModel productDetails;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late PageController pageController;
  Timer? timer;
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    getCurrentProductCartDetails();
    _startAutoScroll();
    sl<RazorpayService>().init(
      onSuccess: () {
        // sl<CartBloc>().add(ClearCart());
        showModernToast(
          context,
          context.localText.paymentSuccessText,
          const Color.fromARGB(255, 35, 213, 0),
        );
      },
      onError: () {
        showModernToast(
          context,
          context.localText.paymentFailedText,
          const Color.fromARGB(255, 255, 7, 7),
        );
      },
    );
  }

  void _startAutoScroll() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (widget.productDetails.productImages.length > 1) {
        if (currentPage < widget.productDetails.productImages.length - 1) {
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
    sl<RazorpayService>().dispose();
    super.dispose();
  }

  Future<void> getCurrentProductCartDetails() async {
    final cartItems = await CartManager.getCart();
    final exists = cartItems.any(
      (item) => item.id == widget.productDetails.productId,
    );
    setState(() {
      isItemInCart = exists;
    });
  }

  bool isItemInCart = false;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> _selectedSize = ValueNotifier<String>("7 UK");
    final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildProSliverAppBar(
              context,
              pageController,
              widget.productDetails,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(context.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: widget.productDetails.productImages.length,
                        effect: WormEffect(
                          dotHeight: 7,
                          dotWidth: 7,
                          activeDotColor: context.appColors.primary,
                          spacing: 8,
                          dotColor: context.appColors.primaryTextColor,
                        ),
                      ),
                    ),
                    _buildProductHeader(context, widget.productDetails),
                    SizedBox(height: context.height * 0.02),
                    _buildSizeSelection(
                      context,
                      _selectedSize,
                      widget.productDetails,
                    ),
                    SizedBox(height: context.height * 0.02),
                    _buildProductDescription(
                      _isExpanded,
                      widget.productDetails,
                      context,
                    ),
                    SizedBox(height: context.height * 0.03),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: isItemInCart
                                ? () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      MainDashboardScreen.routeName,
                                      arguments: 2,
                                    );
                                  }
                                : () {
                                    sl<CartBloc>().add(
                                      AddItemEvent(
                                        CartItem(
                                          id:
                                              widget.productDetails.productId ??
                                              "",
                                          desc:
                                              widget
                                                  .productDetails
                                                  .description ??
                                              "",
                                          name:
                                              widget
                                                  .productDetails
                                                  .productName ??
                                              "",
                                          imageUrl: widget
                                              .productDetails
                                              .productImages[0],
                                          price: widget
                                              .productDetails
                                              .sellingPrice!
                                              .toDouble(),
                                          quantity: 1,
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      isItemInCart = true;
                                    });
                                    // sl<CartBloc>().add(ClearCart());
                                  },
                            icon: const Icon(Icons.shopping_cart_outlined),

                            label: isItemInCart
                                ? FittedBox(
                                    child: Text(context.localText.goToCartText),
                                  )
                                : FittedBox(
                                    child: Text(
                                      context.localText.addToCartText,
                                    ),
                                  ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  context.appColors.addToCartBgColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                vertical: context.height * 0.015,
                                horizontal: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (widget.productDetails.sellingPrice != null) {
                                sl<RazorpayService>().openCheckout(
                                  amount:
                                      widget.productDetails.sellingPrice ?? 0,
                                  contact: '7350223740',
                                  email: 'agarwaldev626@gmail.com',
                                );
                              }
                            },
                            icon: const Icon(Icons.touch_app_outlined),
                            label: FittedBox(
                              child: Text(context.localText.buyNowText),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.appColors.buyNowBgColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                vertical: context.height * 0.015,
                                horizontal: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.height * 0.02),
                    _buildDeliveryInfo(context, widget.productDetails),
                    SizedBox(height: context.height * 0.04),
                    _buildSimilarItemsSection(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildProSliverAppBar(
  BuildContext context,
  PageController controller,
  ProductDetailsModel productDetails,
) {
  return SliverAppBar(
    expandedHeight: context.height * 0.3, // Large image area
    pinned: true,
    stretch: true, // Allows image to expand when pulling down
    backgroundColor: context.appColors.scaffoldBg,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    leadingWidth: 40,
    leading: InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          CupertinoIcons.arrow_left,
          size: 18,
          color: Colors.black,
        ),
      ),
    ),
    flexibleSpace: FlexibleSpaceBar(
      stretchModes: const [
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
      ],
      background: Hero(
        // Ensure this tag matches the one in your Product List item
        tag: productDetails.productId ?? 'product_image',
        child: PageView.builder(
          controller: controller,
          itemCount: productDetails.productImages.length,
          itemBuilder: (context, index) {
            return CachedNetworkImage(
              imageUrl: productDetails.productImages[index],
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.grey[200]),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          },
        ),
      ),
    ),
  );
}

Widget _buildSizeSelection(
  BuildContext context,
  ValueNotifier<String> selectedSize,
  ProductDetailsModel productDetails,
) {
  return ValueListenableBuilder<String>(
    valueListenable: selectedSize,
    builder: (context, currentSize, _) {
      final List<String> sizes = ["6 UK", "7 UK", "8 UK", "9 UK", "10 UK"];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${context.localText.sizeText}: $currentSize",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.appColors.primaryTextColor,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: sizes.map((size) {
              return _buildSizeChip(
                size: size,
                isSelected:
                    size ==
                    currentSize, // Check if this chip is the selected one
                onTap: () {
                  selectedSize.value =
                      size; // Update the value to trigger a UI refresh
                },
                context: context,
              );
            }).toList(),
          ),
        ],
      );
    },
  );
}

// Widget _buildActionButtons(
//   BuildContext context,
//   ProductDetailsModel productDetails,
// ) {
//   bool isItemIncart = false;
//   return
// }

Widget _buildProductHeader(
  BuildContext context,
  ProductDetailsModel productDetails,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        productDetails.productName ?? "",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: context.appColors.primaryTextColor,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        productDetails.description ?? "",
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          // Generate stars based on rating
          ...List.generate(
            4,
            (index) => const Icon(Icons.star, color: Colors.amber, size: 18),
          ),
          const Icon(Icons.star_half, color: Colors.amber, size: 18),
          const SizedBox(width: 8),
          Text(
            productDetails.ratingCount.toString(),
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Text(
            "₹${productDetails.mrp}",
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
          SizedBox(width: 8),
          Text(
            "₹${productDetails.sellingPrice}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: context.appColors.primaryTextColor,
            ),
          ),
          SizedBox(width: 8),
          Text(
            "${productDetails.discountPercentage}% Off",
            style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ],
  );
}

Widget _buildProductDescription(
  ValueNotifier<bool> isExpanded,
  ProductDetailsModel productDetails,
  BuildContext context,
) {
  const String fullDescription =
      "Perhaps the most iconic sneaker of all-time, this original 'Chicago' colorway is the cornerstone to any sneaker collection. Made famous in 1985 by Michael Jordan, the shoe has stood the test of time, becoming the most famous colorway of the Air Jordan 1.";
  const String shortDescription =
      "Perhaps the most iconic sneaker of all-time, this original 'Chicago' colorway is the cornerstone to any sneaker collection. Made famous in 1985 by Michael Jordan... ";

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        context.localText.productDetailsText,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: context.appColors.primaryTextColor,
        ),
      ),
      const SizedBox(height: 8),
      ValueListenableBuilder<bool>(
        valueListenable: isExpanded,
        builder: (context, expanded, child) {
          return RichText(
            text: TextSpan(
              style: TextStyle(
                color: context.appColors.primaryTextColor,
                fontSize: 14,
                height: 1.4,
              ),
              children: [
                TextSpan(text: expanded ? fullDescription : shortDescription),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: InkWell(
                    onTap: () => isExpanded.value = !expanded,
                    child: Text(
                      expanded
                          ? " ${context.localText.showLessText}"
                          : " ${context.localText.showMoreText}",
                      style: TextStyle(
                        color: Colors.pink[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      const SizedBox(height: 16),
      // Icon Feature Row
      Wrap(
        spacing: 10,
        children: [
          _buildFeatureChip(
            Icons.location_on_outlined,
            context.localText.nearestStoreText,
          ),
          _buildFeatureChip(
            Icons.verified_user_outlined,
            context.localText.vIPText,
          ),
          _buildFeatureChip(
            Icons.assignment_return_outlined,
            context.localText.returnPolicyText,
          ),
        ],
      ),
    ],
  );
}

Widget _buildFeatureChip(IconData icon, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey[300]!),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    ),
  );
}

Widget _buildSimilarItemsSection(BuildContext context) {
  List<String> imagesList = [
    MediaResources.shoesOne,
    MediaResources.shoesTwo,
    MediaResources.shoesThree,
    MediaResources.shoesOne,
    MediaResources.shoesFive,
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        context.localText.similarToText,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: context.appColors.primaryTextColor,
        ),
      ),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "282+ ${context.localText.itemsText}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: context.appColors.primaryTextColor,
            ),
          ),
          SizedBox(
            width: context.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          color: context.appColors.primaryTextColor.withValues(
                            alpha: 0.2,
                          ),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            context.localText.sortText,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.appColors.primaryTextColor,
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
                GestureDetector(
                  onTapDown: (details) =>
                      FilterService.showFilterSheet(context),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    width: context.width * 0.25,
                    height: context.height * 0.035,
                    decoration: BoxDecoration(
                      color: context.appColors.bottomNavBg,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: context.appColors.primaryTextColor.withValues(
                            alpha: 0.2,
                          ),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            context.localText.filterText,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.appColors.primaryTextColor,
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
      const SizedBox(height: 16),
      GridView.builder(
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(), // Important: parent CustomScrollView handles scrolling
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio:
              0.45, // Calculates height automatically based on width
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ProductListWithReviews(
            onTap: () {},
            productName: "Nike Sneakers",
            productDesc: "Nike Air Jordan Retro 1 Low Mystic Black",
            sellingPrice: 1900,
            originalPrice: 2499,
            discountPercentage: 20,
            rating: 3.6,
            reviewCount: 48585,
            imageUrl: imagesList[index],
          );
        },
      ),
    ],
  );
}

Widget _buildDeliveryInfo(
  BuildContext context,
  ProductDetailsModel productDetails,
) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      vertical: context.height * 0.015,
      horizontal: context.width * 0.04,
    ),
    decoration: BoxDecoration(
      color: context.appColors.deliveryInfoBgColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        // Subtle pink border only in dark mode to make it pop
        color: Theme.of(context).brightness == Brightness.dark
            ? context.appColors.primary.withOpacity(0.3)
            : Colors.transparent,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${context.localText.deliveryInText} 2 ${context.localText.daysText}",
          style: TextStyle(
            fontSize: 12,
            color: context.appColors.primaryTextColor,
          ),
        ),
        Text(
          "${context.localText.ifOrderedWithinText} 1 ${context.localText.hourText}",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.appColors.primaryTextColor,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSizeChip({
  required String size,
  required bool isSelected,
  required VoidCallback onTap,
  required BuildContext context, // Add this
}) {
  return GestureDetector(
    onTap: onTap, // Trigger the callback
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFFA718C)
            : context.appColors.contentContainerBgColor,
        border: Border.all(color: const Color(0xFFFA718C), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        size,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFFFA718C),
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
  );
}
