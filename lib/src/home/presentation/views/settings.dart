import 'package:e_commerce_app/core/common/widgets/app_text_field.dart';
import 'package:e_commerce_app/core/common/widgets/modern_toast.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/l10n/app_localizations.dart';
import 'package:e_commerce_app/core/common/app/provider/local_provider.dart';

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  String searchQuery = "";
  TextEditingController searchController = TextEditingController();

  // Helper to convert code to Native Name (Optional but professional)
  String getNativeName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'hi':
        return 'हिन्दी (Hindi)';
      case 'mr':
        return 'मराठी (Marathi)';
      case 'es':
        return 'Español (Spanish)';
      case 'fr':
        return 'Français (French)';
      case 'de':
        return 'Deutsch (German)';
      case 'te':
        return 'తెలుగు (Telugu)';
      case 'gu':
        return 'ગુજરાતી (Gujarati)';
      case 'ur':
        return 'اردو (Urdu)';
      case 'pa':
        return 'ਪੰਜਾਬੀ (Punjabi)';
      default:
        return code.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    // Dynamically get all locales defined in your .arb files
    final supportedLocales = AppLocalizations.supportedLocales;

    // Filter list based on search
    final filteredLocales = supportedLocales.where((locale) {
      final name = getNativeName(locale.languageCode).toLowerCase();
      return name.contains(searchQuery.toLowerCase());
    }).toList();

    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 8,
          ),
          child: AppTextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            controller: searchController,
            hintText: context.localText.searchLanguageText,
            hintStyle: TextStyle(
              color: context.appColors.formFillTextColor,
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.search,
              // color: context.appColors.formFillTextColor,
            ),
            fillColor: context.appColors.formFieldFillColor,
            filled: true,
          ),
        ),

        // Language List
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(left: 8, right: 8),
            shrinkWrap: true,
            itemCount: filteredLocales.length,
            separatorBuilder: (context, index) =>
                Divider(color: context.appColors.primaryTextColor),
            itemBuilder: (context, index) {
              final locale = filteredLocales[index];
              final isSelected =
                  localeProvider.locale?.languageCode == locale.languageCode;

              return ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(getNativeName(locale.languageCode)),
                trailing: isSelected
                    ? Icon(Icons.check_circle, color: context.appColors.primary)
                    : null,
                onTap: () {
                  localeProvider.setLocale(locale);
                  // Optional: Provide haptic feedback or a snackbar
                  showModernToast(
                    context,
                    "${context.localText.languageChangedToText} ${getNativeName(locale.languageCode)}",
                    const Color(0xFF323232),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
