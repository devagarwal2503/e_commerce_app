import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/colors.dart';
import 'package:e_commerce_app/src/authentication/presentation/views/sign_in_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.selectedIndex});

  // Track which index is currently active
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            transform: const GradientRotation(75),
            colors: context.appColors.mainGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // Use Column with Spacer to push Logout to the bottom
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: context.height * 0.05),
                children: [
                  _drawerItem(
                    context,
                    Icons.home_outlined,
                    context.localText.homeText,
                    0,
                  ),
                  _drawerItem(
                    context,
                    Icons.favorite_border,
                    context.localText.wishlistText,
                    1,
                  ),
                  _drawerItem(
                    context,
                    Icons.shopping_cart_outlined,
                    context.localText.cartText,
                    2,
                  ),
                  _drawerItem(
                    context,
                    Icons.search,
                    context.localText.searchText,
                    3,
                  ),
                  _drawerItem(
                    context,
                    Icons.settings_outlined,
                    context.localText.settingText,
                    4,
                  ),
                ],
              ),
            ),

            // The Bottom Section
            const Divider(color: Colors.white54, indent: 20, endIndent: 20),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: Text(
                context.localText.logoutText,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignInScreen.routeName,
                  (route) => false,
                );
              },
            ),
            SizedBox(height: context.height * 0.02), // Bottom safe area
          ],
        ),
      ),
    );
  }

  // Helper widget to reduce code duplication and handle selection
  Widget _drawerItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final bool isSelected = selectedIndex == index;

    return Container(
      // padding: EdgeInsets.only(left: 8),
      margin: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: isSelected ? CustomColors.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.white : Colors.white),

        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        // Highlight the background of the selected item
        selected: isSelected,
        selectedTileColor: Colors.white.withOpacity(0.1),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            '/main-screen',
            arguments: index,
          );
          // Add your navigation logic here if it's not handled by the parent
        },
      ),
    );
  }
}
