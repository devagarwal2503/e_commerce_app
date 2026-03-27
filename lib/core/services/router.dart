import 'package:e_commerce_app/core/common/views/page_not_found.dart';
import 'package:e_commerce_app/core/common/views/splash_screen.dart';
import 'package:e_commerce_app/core/services/injection_container.dart';
import 'package:e_commerce_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:e_commerce_app/src/authentication/presentation/views/forgot_password_screen.dart';
import 'package:e_commerce_app/src/authentication/presentation/views/sign_in_screen.dart';
import 'package:e_commerce_app/src/authentication/presentation/views/sign_up_screen.dart';
import 'package:e_commerce_app/core/common/views/main_dashboard_screen.dart';
import 'package:e_commerce_app/src/cart/data/model/product_details_model.dart';
import 'package:e_commerce_app/src/cart/presentation/bloc/product_details_bloc.dart';
import 'package:e_commerce_app/src/product_details/presentation/views/product_details.dart';
import 'package:e_commerce_app/src/profile/presentation/views/profile_scree.dart';
import 'package:e_commerce_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:e_commerce_app/src/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return _pageBuilder((_) => const SplashScreen(), settings: settings);
    case OnBoardingScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<OnBoardingCubit>(),
          child: const OnBoardingScreen(),
        ),
        settings: settings,
      );
    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthenticationBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );
    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthenticationBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );
    case MainDashboardScreen.routeName:
      int index = 0;
      if (settings.arguments != null) {
        index = settings.arguments as int;
      }
      return _pageBuilder(
        (_) => MainDashboardScreen(selectedIndex: index),
        settings: settings,
      );
    case PageNotFound.routeName:
      return _pageBuilder((_) => const PageNotFound(), settings: settings);
    case ProfileScreen.routeName:
      return _pageBuilder((_) => const ProfileScreen(), settings: settings);
    case ProductDetailsPage.routeName:
      ProductDetailsModel productDetails = ProductDetailsModel(
        productId: "",
        productName: "",
        description: "",
        mrp: 0,
        sellingPrice: 0,
        discountPercentage: 0,
        averageRating: 0,
        ratingCount: 0,
        productImages: [],
      );
      if (settings.arguments != null) {
        productDetails = settings.arguments as ProductDetailsModel;
      }
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<ProductDetailsBloc>(),
          child: ProductDetailsPage(productDetails: productDetails),
        ),
        settings: settings,
      );
    case ForgotPasswordScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthenticationBloc>(),
          child: const ForgotPasswordScreen(),
        ),
        settings: settings,
      );

    default:
      return _pageBuilder((_) => const PageNotFound(), settings: settings);
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
    pageBuilder: (context, animation, secondaryAnimation) => page(context),
  );
}
