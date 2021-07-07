#!/usr/bin/env bash

windowClassName="Minecraft\* "
frequency=1
primaryMouseButton=1
secondaryMouseButton=3
disableSecondary=
holdButton=
buttonAction="click"

function help() {
  echo ""
  echo "Autoclicking utility for Minecraft:"
  echo ""
  echo "Optional parameters (need to be added before other parameters):"
  echo "  f - frequency of clicking in seconds. Default '1'"
  echo "  m - hold button instead of click. Default 'false'"
  echo "  d - don't hold secondary button (e.g. eat). Default 'true'"

  exit
}

while getopts ":f:dmh" opt; do
  case "${opt}" in
  f) frequency="${OPTARG}" ;;
  d) disableSecondary=true ;;
  m) buttonAction="mousedown" ;;
  h) help ;;
  *)
    echo "Invalid Option: -$OPTARG" 1>&2
    help
    ;;
  esac
done
shift $((OPTIND - 1))


windowId=$(xdotool search --classname "$windowClassName")

if [[ -z "$disableSecondary" ]]; then
  xdotool mousedown --window "$windowId" "$secondaryMouseButton" &
fi

while true
do
	xdotool "$buttonAction" --window "$windowId" "$primaryMouseButton"
	sleep "$frequency"
done
