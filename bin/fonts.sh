#!/bin/bash

function dumzip {
  expect <<EOF

log_user 0
spawn unzip ${1}
expect {
  replace {
    send "N\r"
  }
}
EOF
}

FONT_DIR="${HOME}/.local/share/fonts"

GOOGLE_FONT_URL='https://fonts.google.com/download?family='
GOOGLE_FONTS=(
  "Andika%20New%20Basic"
  "Cutive%20Mono"
  "Fira%20Code"
  "Fira%20Mono"
  "Indie%20Flower"
  "JetBrains%20Mono"
  "Langar"
  "Major%20Mono%20Display"
  "Noto%20Sans"
  "Nova%20Flat"
  "Nova%20Mono"
  "Open%20Sans"
  "Roboto"
  "Roboto%20Mono"
  "Source%20Code%20Pro"
  "Syne%20Mono"
  "VT323"
  "Xanh%20Mono"
)

mkdir -p ${FONT_DIR}
cd ${FONT_DIR}

for i in ${GOOGLE_FONTS[@]}; do
  echo -n "$(printf "%-47s" "Installing font $(sed 's/%20/ /g' <<< ${i})")"
  curl -so font.zip "${GOOGLE_FONT_URL}${i}"
  dumzip font.zip
  rm *.txt font.zip
  echo " ✓"
done

POWERLINE_FONT_URL='https://github.com/powerline/fonts/raw/master/'
POWERLINE_FONTS=(
  'FiraMono/FuraMono-Bold%20Powerline.otf'
  'FiraMono/FuraMono-Medium%20Powerline.otf'
  'FiraMono/FuraMono-Regular%20Powerline.otf'
  'ProFont/ProFont%20Bold%20For%20Powerline.ttf'
  'ProFont/ProFont%20For%20Powerline.ttf'
)

for i in ${POWERLINE_FONTS[@]}; do
  echo -n "$(printf "%-47s" "Installing font $((cut -d/ -f2 | sed 's/%20/ /g') <<< ${i})")"
  wget -q "${POWERLINE_FONT_URL}${i}"
  echo " ✓"
done
