import 'package:e_commerce_app/core/common/views/page_not_found.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class DealsBanner extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final IconData? leadingIcon;

  const DealsBanner({
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    if (leadingIcon != null) ...[
                      Icon(leadingIcon, color: Colors.white, size: 16),
                      const SizedBox(width: 6),
                    ],
                    Flexible(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Button
          const SizedBox(width: 10),
          UnconstrainedBox(
            alignment: Alignment.centerLeft,
            child: Container(
              constraints: BoxConstraints(maxWidth: 150),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, PageNotFound.routeName);
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ), // Control the "closeness" of the border
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          context.localText.viewAllText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
