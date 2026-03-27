#!/bin/bash

if [ "$1" == "clean" ]; then
    echo "🗑️ Cleaning old translations for a fresh sync..."
    # This deletes all .arb files EXCEPT the English one
    find lib/l10n -name "app_*.arb" ! -name "app_en.arb" -delete
fi

# 1. Run Python script to auto-generate/translate .arb files
echo "Step 1: Translating languages..."
python translate.py

# 2. Run Flutter localization to generate Dart code (the i10n/i18n classes)
echo "Step 2: Generating Flutter localization classes..."
flutter gen-l10n

echo "Done! You can now use AppLocalizations.of(context) in your code."