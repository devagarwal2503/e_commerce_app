import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:e_commerce_app/src/profile/presentation/views/profile_scree.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({required this.onDrawerTap, super.key});

  final VoidCallback onDrawerTap;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: false,
      // --- Visual Fixes ---
      surfaceTintColor: Colors.transparent,
      backgroundColor: context.appColors.scaffoldBg,
      automaticallyImplyLeading: false,
      leading: Builder(
        builder: (context) {
          return InkWell(
            onTap: onDrawerTap,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.appColors.smallContainerBgColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Image.asset(
                MediaResources.drawerIcon,
                color: context.appColors.primaryTextColor,
              ),
            ),
          );
        },
      ),
      title: Image.asset(
        MediaResources.logoWithName,
        width: context.width * 0.22,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(100),
              child: Image.asset(MediaResources.profile, fit: BoxFit.fill),
            ),
            onTap: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
        ),
      ],
    );
  }
}
