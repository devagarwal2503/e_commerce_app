import 'package:e_commerce_app/core/common/app/provider/user_provider.dart';
import 'package:e_commerce_app/core/resources/colors.dart';
import 'package:e_commerce_app/core/resources/fonts.dart';
import 'package:e_commerce_app/core/services/injection_container.dart';
import 'package:e_commerce_app/core/common/app/provider/local_provider.dart';
import 'package:e_commerce_app/core/services/router.dart';
import 'package:e_commerce_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFvYmxhaHl2aGt3a2FvcnFybGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUwMzEwNzEsImV4cCI6MjA5MDYwNzA3MX0.KCntLTKHcO0Ir9XmeZ5n6pOBnw914T5dsvBRVLgXeRs",
    url: "https://aoblahyvhkwkaorqrlcx.supabase.co",
  );
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: sl<LocaleProvider>()),
        ChangeNotifierProvider.value(value: sl<UserProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return MaterialApp(
          locale: localeProvider.locale,
          // locale: Locale("mr"),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          debugShowCheckedModeBanner: false,
          title: 'eCommerce App',
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0XFFF9F9F9),
            useMaterial3: true,
            fontFamily: Fonts.montserrat,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            extensions: [CustomColors.light],
            colorScheme: ColorScheme.fromSwatch(
              accentColor: const Color(0XFFF83758),
            ),
          ),
          themeMode: ThemeMode.system,
          // themeMode: ThemeMode.dark,
          darkTheme: ThemeData(
            scaffoldBackgroundColor: Color(0XFF121212),
            useMaterial3: true,
            fontFamily: Fonts.montserrat,
            brightness: Brightness.dark, // Essential for system dark mode
            extensions: [CustomColors.dark],
            colorScheme: ColorScheme.fromSwatch(
              brightness: Brightness.dark,
              accentColor: const Color(0XFFF83758),
            ),
          ),
          onGenerateRoute: generateRoute,
        );
      },
    );
  }
}
