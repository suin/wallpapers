#!/usr/bin/env zsh

set -eux

BASE_DIR=$(cd "$(dirname "$0")"; pwd)
IMAGE_DIR="$BASE_DIR/images"

: "Check if wallpaper directory exists" && {
  [ -d "$BASE_DIR" ] || exit
}

: "Check if wallpaper exists" && {
  command -v wallpaper > /dev/null || brew install wallpaper
}

: "Set wallpapers" && {
  KEY_NUMBER_1=18
  KEY_RIGHT=124

  function press_key_with_control() {
      osascript -e "tell application \"System Events\" to key code $1 using control down"
  }

  # Go back to the first screen
  press_key_with_control $KEY_NUMBER_1
  sleep 1

  for filename in $IMAGE_DIR/*.{jpg,jpeg,png}(N)
  do
    # Set the given wallpaper to the current screen
    wallpaper set --screen main "$filename"
    sleep 2

    # Go forward next screen
    press_key_with_control $KEY_RIGHT
    sleep 1
  done
}

: "Shows the result" && {
  /System/Applications/Mission\ Control.app/Contents/MacOS/Mission\ Control
}
