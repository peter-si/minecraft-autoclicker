#!/usr/bin/env bash

windowClassName="Minecraft\* "
frequency=1
primaryMouseButton=1
secondaryMouseButton=3
disableSecondary=

function help() {
  echo ""
  echo "Autoclicking utility for Minecraft:"
  echo ""
  echo "Optional parameters (need to be added before other parameters):"
  echo "  f - frequency of clicking in seconds. Default '1'"
  echo "  d - don't hold secondary button (e.g. eat). Default 'true'"

  exit
}

while getopts ":f:dh" opt; do
  case "${opt}" in
  f) frequency="${OPTARG}" ;;
  d) disableSecondary=true ;;
  h) help ;;
  *)
    echo "Invalid Option: -$OPTARG" 1>&2
    help
    ;;
  esac
done
shift $((OPTIND - 1))


windowId=$(xdotool search --classname "$windowClassName")
echo "$windowId"

if [[ -z "$disableSecondary" ]]; then
  xdotool mousedown --window "$windowId" "$secondaryMouseButton" &
fi

while true
do
	xdotool click --window "$windowId" "$primaryMouseButton"
	sleep "$frequency"
done
