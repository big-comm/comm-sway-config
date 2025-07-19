#!/bin/bash

CONFIG_FILE="$HOME/.config/sway/config"
I18N_DIR="$HOME/.config/sway/scripts/i18n"
DEFAULT_LANG="en"

LOCALE=${LANG:-en_US.UTF-8}
LANG_CODE=${LOCALE%%.*}
LANG_SHORT=${LANG_CODE%%_*}

if [ -f "$I18N_DIR/keybinds_${LANG_CODE}.lang" ]; then
    TRANSLATION_FILE="$I18N_DIR/keybinds_${LANG_CODE}.lang"
elif [ -f "$I18N_DIR/keybinds_${LANG_SHORT}.lang" ]; then
    TRANSLATION_FILE="$I18N_DIR/keybinds_${LANG_SHORT}.lang"
else
    TRANSLATION_FILE="$I18N_DIR/keybinds_${DEFAULT_LANG}.lang"
fi

PROMPT_TITLE="Sway Keybindings"
MISSING_TRANSLATION_MSG="MISSING TRANSLATION"

if [ -f "$TRANSLATION_FILE" ]; then
    temp_prompt=$(grep -E "^ui.prompt_title=" "$TRANSLATION_FILE" | cut -d'=' -f2-)
    if [ -n "$temp_prompt" ]; then
        PROMPT_TITLE="$temp_prompt"
    fi
    temp_missing=$(grep -E "^ui.missing_translation=" "$TRANSLATION_FILE" | cut -d'=' -f2-)
    if [ -n "$temp_missing" ]; then
        MISSING_TRANSLATION_MSG="$temp_missing"
    fi
fi

MOD_KEY=$(grep -E '^\s*set\s+\$mod\s+' "$CONFIG_FILE" | awk '{print $3}')
MOD_DISPLAY_NAME="SUPER"
if [ "$MOD_KEY" == "Mod1" ]; then
    MOD_DISPLAY_NAME="ALT"
fi

KEYBINDS=$(awk -v mod_name="$MOD_DISPLAY_NAME" -v missing_text="$MISSING_TRANSLATION_MSG: " '
    FNR==NR {
        if ($0 ~ /^[ \t]*#/ || $0 == "") next;
        match($0, /=/);
        key = substr($0, 1, RSTART - 1);
        value = substr($0, RSTART + 1);
        
        gsub(/^[ \t]+|[ \t]+$/, "", key);
        gsub(/^[ \t]+|[ \t]+$/, "", value);

        t[key] = value;
        next;
    }
    /^\s*bindsym/ && /#>/ && $0 !~ /XF86/ {
        keys = $2; 
        
        split($0, parts, /\s*#>\s*/);
        translation_key = parts[2];
        gsub(/^[ \t]+|[ \t]+$/, "", translation_key);

        description = t[translation_key];
        
        if (description == "") {
            description = missing_text translation_key;
        }

        gsub(/\$mod/, mod_name, keys);
        gsub(/\+/, " + ", keys);
        sub(/--locked\s*/, "", keys); 

        print "<b>" keys "</b>\n\t<small><i>" description "</i></small>"
    }
' "$TRANSLATION_FILE" "$CONFIG_FILE")

echo -e "$KEYBINDS" | wofi --dmenu --insensitive \
    --prompt "$PROMPT_TITLE" \
    --width 60% --height 70% \
    --allow-markup