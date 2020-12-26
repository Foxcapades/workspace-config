#!/bin/bash

CODE_DIR="$HOME/Code"

if [ -d "$CODE_DIR" ]; then
  echo "Code directory already exists, skipping step."
  exit 1
fi

FX_DIR="$CODE_DIR/foxcapades"
GO_DIR="$CODE_DIR/.go"

UPENN_DIR="$CODE_DIR/upenn"
THIRD_DIR="$CODE_DIR/third-party"

toCreate=(
  "$FX_DIR"
  "$GO_DIR"
  "$UPENN_DIR"
  "$THIRD_DIR"
)

for i in ${toCreate[@]}; do
  if [ ! -d "$i" ]; then
    if [ -f "$i" ]; then
      echo "Path exists and is not a directory: $i" >2
      exit 1
    fi

    mkdir -p "$i"
  fi
done

goGithub="${GO_DIR}/src/github.com"
goFx="${goGithub}/foxcapades"
goVDB="${goGithub}/veupathdb"

mkdir -p "$goFx" "$goVDB"

ln -s "$goFx" "$FX_DIR/go"
ln -s "$goVDB" "$UPENN_DIR/go"

mkdir -p "$GO_DIR/bin"