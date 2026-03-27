import json
import os
from deep_translator import GoogleTranslator

# Config
BASE_DIR = 'lib/l10n'
EN_FILE = os.path.join(BASE_DIR, 'app_en.arb')
LANGUAGES = ['hi', 'mr', 'es', 'fr', 'de', 'mr', 'te', 'gu', 'ur', 'pa'] # Add your 20 languages here

def translate_arb():
    with open(EN_FILE, 'r') as f:
        en_data = json.load(f)

    for lang in LANGUAGES:
        file_path = os.path.join(BASE_DIR, f'app_{lang}.arb')
        
        # Load existing translations or start fresh
        if os.path.exists(file_path):
            with open(file_path, 'r', encoding='utf-8') as f:
                lang_data = json.load(f)
        else:
            lang_data = {"@@locale": lang}

        # Translate missing keys
        updated = False
        translator = GoogleTranslator(source='en', target=lang)

        for key, value in en_data.items():
            if key.startswith('@'): continue # Skip metadata keys
            if key not in lang_data:
                print(f"Translating '{key}' to {lang}...")
                lang_data[key] = translator.translate(value)
                updated = True
        
        if updated:
            with open(file_path, 'w', encoding='utf-8') as f:
                json.dump(lang_data, f, ensure_ascii=False, indent=2)

if __name__ == "__main__":
    translate_arb()