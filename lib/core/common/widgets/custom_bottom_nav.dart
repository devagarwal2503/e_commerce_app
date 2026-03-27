import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class PersistentBottomNav extends StatelessWidget {
  final Widget body;
  final ValueNotifier<bool> isVisible;
  final int currentIndex;
  final Function(int) onTap;

  const PersistentBottomNav({
    super.key,
    required this.body,
    required this.isVisible,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      // The "Cart" button in the center
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ValueListenableBuilder(
        valueListenable: isVisible,
        builder: (context, visible, child) {
          return AnimatedSlide(
            duration: const Duration(milliseconds: 300),
            offset: visible ? Offset.zero : const Offset(0, 2),
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: currentIndex == 2
                  ? context.appColors.primary
                  : context.appColors.bottomNavBg,
              elevation: 2,
              onPressed: () => onTap(2), // Index for Cart
              child: Icon(
                Icons.shopping_cart_outlined,
                color: currentIndex == 2
                    ? Colors.white
                    : context.appColors.primaryTextColor,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: isVisible,
        builder: (context, visible, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: visible ? 60 : 0,
            child: Wrap(
              // Wrap prevents overflow errors during animation
              children: [
                BottomAppBar(
                  color: context.appColors.bottomNavBg,
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 8.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _navItem(
                        Icons.home_outlined,
                        context.localText.homeText,
                        0,
                        context,
                      ),
                      _navItem(
                        Icons.favorite_border,
                        context.localText.wishlistText,
                        1,
                        context,
                      ),
                      const SizedBox(width: 20),
                      _navItem(
                        Icons.search,
                        context.localText.searchText,
                        3,
                        context,
                      ),
                      _navItem(
                        Icons.settings_outlined,
                        context.localText.settingText,
                        4,
                        context,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _navItem(
    IconData icon,
    String label,
    int index,
    BuildContext context,
  ) {
    bool isSelected = currentIndex == index;
    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected
                ? context.appColors.primary
                : context.appColors.primaryTextColor,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? context.appColors.primary
                  : context.appColors.primaryTextColor,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
