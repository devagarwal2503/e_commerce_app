import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';

class FilterService {
  // --- 1. PRO SORT MENU ---
  static void showSortMenu(BuildContext context, TapDownDetails details) {
    final x = details.globalPosition.dx;
    final y = details.globalPosition.dy;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(x, y, x, 0),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: context.appColors.contentContainerBgColor,
      items: <PopupMenuEntry<dynamic>>[
        _buildPopupItem(context, Icons.sort, "Price: Low to High"),
        _buildPopupItem(context, Icons.trending_up, "Popularity"),
        const PopupMenuDivider(),
        _buildPopupItem(context, Icons.new_releases_outlined, "Newest First"),
      ],
    );
  }

  // --- 2. PRO FILTER BOTTOM SHEET ---
  static void showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.appColors.contentContainerBgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: context.height * 0.6, // 60% of screen
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const Divider(),
              Expanded(
                child: ListView(
                  children: [
                    _buildFilterCategory(context, "Categories", [
                      "Sneakers",
                      "Running",
                      "Casual",
                      "Formals",
                    ]),
                    _buildFilterCategory(context, "Price Range", [
                      "Under ₹1000",
                      "₹1000 - ₹5000",
                      "Over ₹5000",
                    ]),
                    _buildFilterCategory(context, "Brand", [
                      "Nike",
                      "Adidas",
                      "Puma",
                      "Reebok",
                    ]),
                  ],
                ),
              ),
              _buildApplyButton(context),
            ],
          ),
        );
      },
    );
  }

  // --- PRIVATE HELPER WIDGETS ---

  static PopupMenuItem<dynamic> _buildPopupItem(
    BuildContext context,
    IconData icon,
    String label,
  ) {
    return PopupMenuItem<dynamic>(
      child: Row(
        children: [
          Icon(icon, size: 18, color: context.appColors.primary),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(color: context.theme.textTheme.bodyLarge?.color),
          ),
        ],
      ),
    );
  }

  static Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Filters",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: context.theme.textTheme.bodyLarge?.color,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Clear All",
            style: TextStyle(color: context.appColors.primary),
          ),
        ),
      ],
    );
  }

  static Widget _buildFilterCategory(
    BuildContext context,
    String title,
    List<String> options,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: options
              .map(
                (opt) => Chip(
                  label: Text(opt, style: const TextStyle(fontSize: 12)),
                  backgroundColor: context.theme.scaffoldBackgroundColor,
                  side: BorderSide(
                    color: context.theme.dividerColor.withOpacity(0.1),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  static Widget _buildApplyButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: context.appColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => Navigator.pop(context),
        child: const Text(
          "Apply Filters",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
