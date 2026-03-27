import 'package:e_commerce_app/core/common/app/provider/user_provider.dart';
import 'package:e_commerce_app/core/extensions/app_colors_extension.dart';
import 'package:e_commerce_app/l10n/app_localizations.dart';
import 'package:e_commerce_app/src/authentication/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  AppColorsExtension get appColors => theme.extension<AppColorsExtension>()!;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;

  double get width => size.width;
  double get height => size.height;

  UserProvider get userProvider => read<UserProvider>();

  LocalUser? get currentUser => userProvider.user;

  AppLocalizations get localText => AppLocalizations.of(this)!;
}
