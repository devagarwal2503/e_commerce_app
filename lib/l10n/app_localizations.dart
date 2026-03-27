import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_te.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('gu'),
    Locale('hi'),
    Locale('mr'),
    Locale('pa'),
    Locale('te'),
    Locale('ur')
  ];

  /// No description provided for @previousText.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previousText;

  /// No description provided for @getStartedText.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStartedText;

  /// No description provided for @nextText.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextText;

  /// No description provided for @skipText.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipText;

  /// No description provided for @chooseProductsText.
  ///
  /// In en, this message translates to:
  /// **'Choose Products'**
  String get chooseProductsText;

  /// No description provided for @chooseProductsDescText.
  ///
  /// In en, this message translates to:
  /// **'Dive into an extensive collection of high-quality products curated specifically to match your lifestyle.'**
  String get chooseProductsDescText;

  /// No description provided for @makePaymentText.
  ///
  /// In en, this message translates to:
  /// **'Make Payment'**
  String get makePaymentText;

  /// No description provided for @makePaymentDescText.
  ///
  /// In en, this message translates to:
  /// **'Enjoy complete peace of mind with our military-grade encrypted payment gateway. Choose from a wide variety of trusted options including credit cards, UPI, and digital wallets.'**
  String get makePaymentDescText;

  /// No description provided for @getYourOrderText.
  ///
  /// In en, this message translates to:
  /// **'Get Your Order'**
  String get getYourOrderText;

  /// No description provided for @getYourOrderDescText.
  ///
  /// In en, this message translates to:
  /// **'Experience the joy of lightning-fast delivery right to your doorstep. Track your package in real-time from our warehouse to your home.'**
  String get getYourOrderDescText;

  /// No description provided for @welcomeBackText.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBackText;

  /// No description provided for @continueWithText.
  ///
  /// In en, this message translates to:
  /// **'OR Continue with'**
  String get continueWithText;

  /// No description provided for @createAnAccountText.
  ///
  /// In en, this message translates to:
  /// **'Create An Account '**
  String get createAnAccountText;

  /// No description provided for @signUpText.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpText;

  /// No description provided for @usernameOrEmailText.
  ///
  /// In en, this message translates to:
  /// **'Username or Email'**
  String get usernameOrEmailText;

  /// No description provided for @passwordText.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordText;

  /// No description provided for @confirmPasswordText.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordText;

  /// No description provided for @forgotPasswordText.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordText;

  /// No description provided for @loginText.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginText;

  /// No description provided for @alreadyHaveAnAccountText.
  ///
  /// In en, this message translates to:
  /// **'I Already Have an Account'**
  String get alreadyHaveAnAccountText;

  /// No description provided for @byClickingTheText.
  ///
  /// In en, this message translates to:
  /// **'By clicking the'**
  String get byClickingTheText;

  /// No description provided for @registerText.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerText;

  /// No description provided for @youAgreeToOfferText.
  ///
  /// In en, this message translates to:
  /// **'button, you agree \nto the public offer'**
  String get youAgreeToOfferText;

  /// No description provided for @createAccountText.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountText;

  /// No description provided for @enterYourEmailAddressText.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterYourEmailAddressText;

  /// No description provided for @forgotPasswordMsgText.
  ///
  /// In en, this message translates to:
  /// **'We will send you a message to set or reset your new password'**
  String get forgotPasswordMsgText;

  /// No description provided for @submitText.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitText;

  /// No description provided for @homeText.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeText;

  /// No description provided for @wishlistText.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlistText;

  /// No description provided for @searchText.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchText;

  /// No description provided for @settingText.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get settingText;

  /// No description provided for @cartText.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cartText;

  /// No description provided for @logoutText.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutText;

  /// No description provided for @thisFieldIsRequiredText.
  ///
  /// In en, this message translates to:
  /// **'This field is Required'**
  String get thisFieldIsRequiredText;

  /// No description provided for @goToHomeText.
  ///
  /// In en, this message translates to:
  /// **'GO TO HOME'**
  String get goToHomeText;

  /// No description provided for @pageUnderConstructionText.
  ///
  /// In en, this message translates to:
  /// **'page is under Construction and will be available soon!!!!'**
  String get pageUnderConstructionText;

  /// No description provided for @shopNowText.
  ///
  /// In en, this message translates to:
  /// **'Shop Now'**
  String get shopNowText;

  /// No description provided for @viewAllText.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAllText;

  /// No description provided for @allFeaturedText.
  ///
  /// In en, this message translates to:
  /// **'All Featured'**
  String get allFeaturedText;

  /// No description provided for @sortText.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sortText;

  /// No description provided for @filterText.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterText;

  /// No description provided for @beautyText.
  ///
  /// In en, this message translates to:
  /// **'Beauty'**
  String get beautyText;

  /// No description provided for @dealOfTheDayText.
  ///
  /// In en, this message translates to:
  /// **'Deal of the Day'**
  String get dealOfTheDayText;

  /// No description provided for @remainingText.
  ///
  /// In en, this message translates to:
  /// **'remaining'**
  String get remainingText;

  /// No description provided for @trendingProductsText.
  ///
  /// In en, this message translates to:
  /// **'Trending Products'**
  String get trendingProductsText;

  /// No description provided for @lastDateText.
  ///
  /// In en, this message translates to:
  /// **'Last Date'**
  String get lastDateText;

  /// No description provided for @searchLanguageText.
  ///
  /// In en, this message translates to:
  /// **'Search Language...'**
  String get searchLanguageText;

  /// No description provided for @paymentFailedText.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentFailedText;

  /// No description provided for @paymentSuccessText.
  ///
  /// In en, this message translates to:
  /// **'Payment Success'**
  String get paymentSuccessText;

  /// No description provided for @emptyCartText.
  ///
  /// In en, this message translates to:
  /// **'EMPTY CART'**
  String get emptyCartText;

  /// No description provided for @deliveryByText.
  ///
  /// In en, this message translates to:
  /// **'Delivery by'**
  String get deliveryByText;

  /// No description provided for @applyCouponsText.
  ///
  /// In en, this message translates to:
  /// **'Apply Coupons'**
  String get applyCouponsText;

  /// No description provided for @selectText.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectText;

  /// No description provided for @orderPaymentDetailsText.
  ///
  /// In en, this message translates to:
  /// **'Order Payment Details'**
  String get orderPaymentDetailsText;

  /// No description provided for @orderAmountsText.
  ///
  /// In en, this message translates to:
  /// **'Order Amounts'**
  String get orderAmountsText;

  /// No description provided for @convenienceFeeText.
  ///
  /// In en, this message translates to:
  /// **'Convenience Fee'**
  String get convenienceFeeText;

  /// No description provided for @knowMoreText.
  ///
  /// In en, this message translates to:
  /// **'Know More'**
  String get knowMoreText;

  /// No description provided for @deliveryFeeText.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get deliveryFeeText;

  /// No description provided for @freeText.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get freeText;

  /// No description provided for @orderTotalText.
  ///
  /// In en, this message translates to:
  /// **'Order Total'**
  String get orderTotalText;

  /// No description provided for @viewDetailsText.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetailsText;

  /// No description provided for @proceedToPaymentText.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Payment'**
  String get proceedToPaymentText;

  /// No description provided for @sizeText.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get sizeText;

  /// No description provided for @quantityText.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityText;

  /// No description provided for @goToCartText.
  ///
  /// In en, this message translates to:
  /// **'Go to Cart'**
  String get goToCartText;

  /// No description provided for @addToCartText.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCartText;

  /// No description provided for @buyNowText.
  ///
  /// In en, this message translates to:
  /// **'Buy Now'**
  String get buyNowText;

  /// No description provided for @productDetailsText.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetailsText;

  /// No description provided for @showLessText.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get showLessText;

  /// No description provided for @showMoreText.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get showMoreText;

  /// No description provided for @nearestStoreText.
  ///
  /// In en, this message translates to:
  /// **'Nearest Store'**
  String get nearestStoreText;

  /// No description provided for @vIPText.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get vIPText;

  /// No description provided for @returnPolicyText.
  ///
  /// In en, this message translates to:
  /// **'Return policy'**
  String get returnPolicyText;

  /// No description provided for @similarToText.
  ///
  /// In en, this message translates to:
  /// **'Similar To'**
  String get similarToText;

  /// No description provided for @itemsText.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get itemsText;

  /// No description provided for @deliveryInText.
  ///
  /// In en, this message translates to:
  /// **'Delivery in'**
  String get deliveryInText;

  /// No description provided for @daysText.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get daysText;

  /// No description provided for @ifOrderedWithinText.
  ///
  /// In en, this message translates to:
  /// **'If ordered within'**
  String get ifOrderedWithinText;

  /// No description provided for @hourText.
  ///
  /// In en, this message translates to:
  /// **'Hour'**
  String get hourText;

  /// No description provided for @languageChangedToText.
  ///
  /// In en, this message translates to:
  /// **'Language changed to'**
  String get languageChangedToText;

  /// No description provided for @swipeAgainToExitText.
  ///
  /// In en, this message translates to:
  /// **'Swipe again to exit'**
  String get swipeAgainToExitText;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fr', 'gu', 'hi', 'mr', 'pa', 'te', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'gu': return AppLocalizationsGu();
    case 'hi': return AppLocalizationsHi();
    case 'mr': return AppLocalizationsMr();
    case 'pa': return AppLocalizationsPa();
    case 'te': return AppLocalizationsTe();
    case 'ur': return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
