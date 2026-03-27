import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class ProductListWithReviews extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String productDesc;
  final double sellingPrice;
  final double originalPrice;
  final int discountPercentage;
  final double rating; // e.g., 4.5
  final int reviewCount;
  final VoidCallback onTap;

  const ProductListWithReviews({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.productDesc,
    required this.sellingPrice,
    required this.originalPrice,
    required this.discountPercentage,
    required this.rating,
    required this.reviewCount,
    required this.onTap,
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
              child: Image.asset(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Product Name
                  Text(
                    productName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: context.appColors.primaryTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // 3. Product Description
                  Text(
                    productDesc,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // 4. Pricing Row
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
                      const SizedBox(width: 8),
                      Text(
                        '$discountPercentage% Off',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 5. Rating and Review Count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRatingStars(rating),
                      const SizedBox(width: 4),
                      Text(
                        '$reviewCount',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to generate stars based on rating
  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }
}
