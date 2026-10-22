#!/usr/bin/env bash
# Usage : ./build.sh webos | tizen | web
set -euo pipefail
cd "$(dirname "$0")"

TARGET="${1:-}"
mkdir -p dist

stage() {  # stage <cible> : copie web/ + fichiers spécifiques à la plateforme
  rm -rf "build/$1"
  mkdir -p "build/$1"
  cp -r web/. "build/$1/"
  cp -r "$1"/. "build/$1/"
}

case "$TARGET" in
  webos)
    stage webos
    ares-package "build/webos" -o dist
    ;;
  tizen)
    stage tizen
    # .wgt NON signé : voir docs/INSTALL.md pour la signature avec Tizen Studio
    ( cd build/tizen && zip -qr ../../dist/RoseOSTv0-unsigned.wgt . )
    ;;
  web)
    rm -rf dist/web
    mkdir -p dist/web
    cp -r web/. dist/web/
    ;;
  *)
    echo "Usage: $0 {webos|tizen|web}" >&2
    exit 2
    ;;
esac
echo "OK : $TARGET"
