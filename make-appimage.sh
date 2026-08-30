#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q kcalc | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://invent.kde.org/utilities/kcalc/-/raw/master/icons/256-apps-accessories-calculator.png?ref_type=heads
export DESKTOP=/usr/share/applications/org.kde.kcalc.desktop
export STARTUPWMCLASS=org.kde.kcalc
export USE_HOST_DRIVERS_EXPERIMENTAL=1

# Deploy dependencies
quick-sharun /usr/bin/kcalc /usr/share/config.kcfg

# Turn AppDir into AppImage
quick-sharun --make-appimage
