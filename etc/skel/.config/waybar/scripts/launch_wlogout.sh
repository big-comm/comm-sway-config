#!/bin/bash

LOCALE=$(locale | grep LANG | cut -d'=' -f2 | cut -d'.' -f1)

LAYOUT_DIR="$HOME/.config/wlogout/layouts"

case "$LOCALE" in
  pt_*)   LAYOUT_FILE="$LAYOUT_DIR/layout.pt_BR" ;;
  en_*)   LAYOUT_FILE="$LAYOUT_DIR/layout.en_US" ;;
  es_*)   LAYOUT_FILE="$LAYOUT_DIR/layout.es_ES" ;;
  fr_*)   LAYOUT_FILE="$LAYOUT_DIR/layout.fr_FR" ;;
  de_*)   LAYOUT_FILE="$LAYOUT_DIR/layout.de_DE" ;;
  it_*)   LAYOUT_FILE="$LAYOUT_DIR/layout.it_IT" ;;
  ru_*)   LAYOUT_FILE="$LAYOUT_DIR/layout.ru_RU" ;;
  zh_CN*) LAYOUT_FILE="$LAYOUT_DIR/layout.zh_CN" ;;
  *)      LAYOUT_FILE="$LAYOUT_DIR/layout.en_US" ;;
esac

if [ ! -f "$LAYOUT_FILE" ]; then
  LAYOUT_FILE="$LAYOUT_DIR/layout.en_US"
fi

wlogout --layout "$LAYOUT_FILE"

exit 0