#!/bin/bash

# If lpass is already installed, nothing to do.
if which lpass > /dev/null; then
  exit 0
fi

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "${CWD}/../zsh/variables.zshrc"

cd "${CODE_PATH}/third-party"
git clone https://github.com/lastpass/lastpass-cli
cd lastpass-cli
make
sudo make install