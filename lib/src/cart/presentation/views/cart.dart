import 'package:e_commerce_app/core/common/widgets/modern_toast.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/colors.dart';
import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:e_commerce_app/core/services/injection_container.dart';
import 'package:e_commerce_app/core/services/razorpay_services.dart';
import 'package:e_commerce_app/src/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class CheckoutBody extends StatefulWidget {
  const CheckoutBody({super.key});

  @override
  State<CheckoutBody> createState() => _CheckoutBodyState();
}

class _CheckoutBodyState extends State<CheckoutBody> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCart());
    sl<RazorpayService>().init(
      onSuccess: () {
        sl<CartBloc>().add(ClearCart());
        context.read<CartBloc>().add(LoadCart());
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

  @override
  void dispose() {
    sl<RazorpayService>().dispose(); // Clean up listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime futureDate = DateTime.now().add(const Duration(days: 5));
    String formattedDate = DateFormat('d MMM yyyy').format(futureDate);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadingState) {
          return SizedBox();
        }
        if (state is CartEmptyState) {
          return Container(
            height: context.height * 0.9,
            // constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                transform: GradientRotation(75),
                colors: context.appColors.mainGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),

            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(MediaResources.emptyCart),
                  Text(
                    context.localText.emptyCartText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 10.0,
                      color: const Color(0XFF4A000E),
                      shadows: [
                        const Shadow(
                          blurRadius: 12.0,
                          color: Colors.white,
                          offset: Offset(0, 0),
                        ),
                        Shadow(
                          blurRadius: 25.0,
                          color: const Color(0XFFF83758).withOpacity(0.5),
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is CartLoadedState) {
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                      separatorBuilder: (context, index) {
                        return Divider(height: 10, indent: 20, endIndent: 20);
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final currentItem = state.items[index];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                currentItem.imageUrl,
                                width: context.width * 0.3,
                                height: context.width * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentItem.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      color: context.appColors.primaryTextColor,
                                    ),
                                  ),
                                  Text(
                                    currentItem.desc,
                                    maxLines: 1,

                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildDropdownSelectors(context),
                                  const SizedBox(height: 8),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              "${context.localText.deliveryByText} : ",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                        TextSpan(
                                          text: formattedDate,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: context
                                                .appColors
                                                .primaryTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                    // --- Coupons Section ---
                    SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          Icon(
                            Icons.confirmation_number_outlined,
                            size: 14,
                            color: context.appColors.primaryTextColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            context.localText.applyCouponsText,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: context.appColors.primaryTextColor,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              context.localText.selectText,
                              style: TextStyle(
                                color: CustomColors.primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      context.localText.orderPaymentDetailsText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: context.appColors.primaryTextColor,
                      ),
                    ),
                    // const SizedBox(height: 16),
                    _buildPriceRow(
                      context.localText.orderAmountsText,
                      state.totalAmount.toString(),
                    ),
                    _buildPriceRow(
                      context.localText.convenienceFeeText,
                      context.localText.knowMoreText,
                      isLink: true,
                    ),
                    _buildPriceRow(
                      context.localText.deliveryFeeText,
                      context.localText.freeText,
                      isFree: true,
                    ),
                  ],
                ),
                Column(
                  children: [
                    // const Divider(height: 32),
                    _buildPriceRow(
                      context.localText.orderTotalText,
                      state.totalAmount.toString(),
                      isTotal: true,
                    ),
                    _buildFooterAction(context, state.totalAmount.toInt()),
                  ],
                ),
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  Widget _buildPriceRow(
    String label,
    String value, {
    bool isLink = false,
    bool isFree = false,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isLink
                  ? context.appColors.primary
                  : (isFree
                        ? Colors.green
                        : context.appColors.primaryTextColor),
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 14 : 12,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildFooterAction(BuildContext context, int totalAmount) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
      const SizedBox(height: 8),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                totalAmount.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.primaryTextColor,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  context.localText.viewDetailsText,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.appColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Right side: Proceed Button
          SizedBox(
            width: context.width * 0.55,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                sl<RazorpayService>().openCheckout(
                  amount: totalAmount,
                  contact: '7350223740',
                  email: 'agarwaldev626@gmail.com',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                padding: EdgeInsets.all(0),
              ),
              child: Text(
                context.localText.proceedToPaymentText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: context.height * 0.04),
    ],
  );
}

Widget _buildDropdownSelectors(BuildContext context) {
  return Row(
    children: [
      _buildCustomDropdown(
        label: context.localText.sizeText,
        initialValue: "42",
        items: ["40", "42", "44", "46"],
        onSelected: (value) {},
        context: context,
      ),
      const SizedBox(width: 12),
      _buildCustomDropdown(
        label: context.localText.quantityText,
        initialValue: "1",
        items: ["1", "2", "3", "4", "5"],
        onSelected: (value) {},
        context: context,
      ),
    ],
  );
}

Widget _buildCustomDropdown({
  required String label,
  required String initialValue,
  required List<String> items,
  required Function(String) onSelected,
  required BuildContext context,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: context.appColors.bottomNavBg, // Light grey background
      borderRadius: BorderRadius.circular(4),
      boxShadow: [
        BoxShadow(
          color: context.appColors.primaryTextColor.withValues(alpha: 0.2),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Text(
          "$label ",
          style: TextStyle(
            fontSize: 12,
            color: context.appColors.primaryTextColor,
          ),
        ),
        Text(
          initialValue,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: context.appColors.primaryTextColor,
          ),
        ),
      ],
    ),
  );
}
