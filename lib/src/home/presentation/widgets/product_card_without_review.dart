import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class ProductCardWithoutReview extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String? productDesc; // Made optional
  final double sellingPrice;
  final double originalPrice;
  final int discountPercentage;
  final double? rating; // Nullable to handle "without reviews"
  final int? reviewCount;
  final VoidCallback onTap;
  final bool isNetworkImage;

  const ProductCardWithoutReview({
    super.key,
    required this.imageUrl,
    required this.productName,
    this.productDesc,
    required this.sellingPrice,
    required this.originalPrice,
    required this.discountPercentage,
    this.rating,
    this.reviewCount,
    required this.onTap,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          color: context.appColors.contentContainerBgColor,
          borderRadius: BorderRadius.circular(12),
          // Subtle shadow for that "elevated" portfolio look
          boxShadow: [
            BoxShadow(
              color: context.appColors.primaryTextColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Product Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: isNetworkImage
                  ? CachedNetworkImage(
                      memCacheHeight: 200,
                      memCacheWidth: 500,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: imageUrl,
                      // placeholder: (context, url) =>
                      //     CircularProgressIndicator(), // Widget to show while loading
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error), // Widget to show on error
                    )
                  // Image.network(
                  //     imageUrl,
                  //     height: 100,
                  //     width: double.infinity,
                  //     fit: BoxFit.cover,
                  //   )
                  : Image.asset(
                      imageUrl,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Product Name (Supports up to 2 lines for big names)
                  Text(
                    productName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: context.appColors.primaryTextColor,
                      height: 1.2,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // 3. Optional Product Description
                  if (productDesc != null)
                    Text(
                      productDesc!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: 8),

                  // 4. Pricing
                  Text(
                    '₹$sellingPrice',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: context.appColors.primaryTextColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '₹$originalPrice',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$discountPercentage% off',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(
                            0xFFFF6D6D,
                          ), // Soft red/orange for discount
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  // 5. Conditional Reviews Section
                  if (rating != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildRatingStars(rating!),
                        const SizedBox(width: 4),
                        if (reviewCount != null)
                          Text(
                            '$reviewCount',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          color: const Color(0xFFFFD700),
          size: 14,
        );
      }),
    );
  }
}
