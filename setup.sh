#!/bin/bash

# Where is setup.sh located
CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Record it
echo "export ELLIE_CONF_ROOT='${CWD}'" > "${HOME}/.config/.ellieconfrc"

. "${CWD}/zsh/variables.zshrc"

sudo apt install curl

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo add-apt-repository ppa:openjdk-r/ppa

sudo apt update
sudo apt install \
  asciidoctor \
  bash-completion \
  bat \
  build-essential \
  ca-certificates \
  cmake \
  curl \
  docker.io \
  docker-compose \
  expect \
  git \
  libcurl4 \
  libcurl4-openssl-dev \
  libssl1.1 \
  libssl-dev \
  libxml2 \
  libxml2-dev \
  moreutils \
  openjdk-15-jdk \
  pkg-config \
  powerline \
  python3-pip \
  spotify-client \
  tmux \
  xclip \
  zsh

if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My ZSH already installed. Skipping step."
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

rm "${HOME}/.zshrc"
ln -s "${CWD}/zsh/base.zshrc" "${HOME}/.zshrc"

rm "${HOME}/.tmux.conf"
ln -s "${CWD}/tmux.conf" "${HOME}/.tmux.conf"

#
# Setup Workspace Dirs
#
bash "${CWD}/bin/workspace.sh"

#
# Setup go version manager
#
if [ -f "${GOPATH}/bin/g" ]; then
  echo "Go version manager already installed.  Skipping step."
else
  curl -sSL https://git.io/g-install | sh -s
fi

#
# Setup node version manager
#
if [ -d "$HOME/.nvm" ]; then
  echo "Node version manager already installed.  Skipping step."
else
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
fi

#
# Install fonts
#
bash "${CWD}/bin/fonts.sh"

#
# Install LastPass CLI
#
bash "${CWD}/bin/lpass.sh"

#
# Python stuff
#
pip3 install pygments
pip3 install sshuttle

#
# Java Tools
#
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install gradle
sdk install maven

