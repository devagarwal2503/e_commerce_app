import 'package:e_commerce_app/core/common/views/under_construction.dart';
import 'package:e_commerce_app/core/common/widgets/custom_app_bar.dart';
import 'package:e_commerce_app/core/common/widgets/custom_drawer.dart';
import 'package:e_commerce_app/core/common/widgets/modern_toast.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/services/injection_container.dart';
import 'package:e_commerce_app/src/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce_app/src/cart/presentation/bloc/product_details_bloc.dart';
import 'package:e_commerce_app/src/cart/presentation/views/cart.dart';
import 'package:e_commerce_app/src/home/presentation/views/home_screen_view.dart';
import 'package:e_commerce_app/core/common/widgets/custom_bottom_nav.dart';
import 'package:e_commerce_app/src/home/presentation/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({required this.selectedIndex, super.key});

  static const routeName = '/main-screen';
  final int selectedIndex;

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isNavVisible = ValueNotifier<bool>(true);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isNavVisible.value) _isNavVisible.value = false;
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isNavVisible.value) _isNavVisible.value = true;
      } else {}
    });
  }

  List<Widget> _getPages() {
    return [
      BlocProvider(
        create: (context) => sl<ProductDetailsBloc>(),
        child: const HomeScreen(),
      ),
      PageUnderConstruction(pageName: context.localText.wishlistText),
      BlocProvider(
        create: (context) => sl<CartBloc>(),
        child: const CheckoutBody(),
      ),
      PageUnderConstruction(pageName: context.localText.searchText),
      // const PageUnderConstruction(pageName: "Settings"),
      const LanguageSettingsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    DateTime? _lastPressedAt;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        // 1. If not on Home, go to Home
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return;
        }

        // 2. If on Home, handle the "Double Swipe" logic
        final now = DateTime.now();
        final backButtonHasNotBeenPressedRecently =
            _lastPressedAt == null ||
            now.difference(_lastPressedAt!) > const Duration(seconds: 2);

        if (backButtonHasNotBeenPressedRecently) {
          _lastPressedAt = now;
          showModernToast(
            context,
            context.localText.swipeAgainToExitText,
            const Color(0xFF323232),
          );
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: const Text(
          //       'Swipe again to exit',
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.w600,
          //         fontSize: 14,
          //       ),
          //     ),
          //     duration: const Duration(seconds: 2),
          //     behavior: SnackBarBehavior.floating, // Makes it float
          //     elevation: 6, // Adds the shadow/depth
          //     backgroundColor: const Color(
          //       0xFF323232,
          //     ), // Modern dark grey/charcoal
          //     margin: EdgeInsets.only(
          //       bottom: context.height * 0.05, // Adjusts height from bottom
          //       left: context.width * 0.2, // Makes it narrower/compact
          //       right: context.width * 0.2,
          //     ),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(30), // Pill-shaped
          //     ),
          //   ),
          // );

          return;
        }
        SystemNavigator.pop(animated: true);
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(selectedIndex: _selectedIndex),

        body: PersistentBottomNav(
          currentIndex: _selectedIndex,
          isVisible: _isNavVisible,
          onTap: (index) => setState(() => _selectedIndex = index),
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              CustomSliverAppBar(
                onDrawerTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              _selectedIndex == 0 || _selectedIndex == 2
                  ? SliverToBoxAdapter(child: _getPages()[_selectedIndex])
                  : SliverFillRemaining(child: _getPages()[_selectedIndex]),
            ],
          ),
        ),
      ),
    );
  }
}
