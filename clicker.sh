#!/usr/bin/env bash

windowClassName="Minecraft\* "
frequency=1
primaryMouseButton=1
secondaryMouseButton=3
disableSecondary=
switchButtons=
buttonAction="click"

function help() {
  echo ""
  echo "Autoclicking utility for Minecraft:"
  echo ""
  echo "Optional parameters (need to be added before other parameters):"
  echo "  f - frequency of clicking in seconds. Default '1'"
  echo "  m - hold button instead of click. Default 'false'"
  echo "  d - disable holding of secondary button (e.g. eat). Default 'false'"
  echo "  s - Switch buttons. Default 'false'"
  echo "  h - show help"

  exit
}

while getopts ":f:dmsh" opt; do
  case "${opt}" in
  f) frequency="${OPTARG}" ;;
  d) disableSecondary=true ;;
  m) buttonAction="mousedown" ;;
  s) switchButtons=true ;;
  h) help ;;
  *)
    echo "Invalid Option: -$OPTARG" 1>&2
    help
    ;;
  esac
done
shift $((OPTIND - 1))


windowId=$(xdotool search --classname "$windowClassName")

if [[ "$switchButtons" ]]; then
  tmpBtn="$primaryMouseButton"
  primaryMouseButton="$secondaryMouseButton"
  secondaryMouseButton="$tmpBtn"
fi


if [[ -z "$disableSecondary" ]]; then
  xdotool mousedown --window "$windowId" "$secondaryMouseButton" &
fi

while true
do
	xdotool "$buttonAction" --window "$windowId" "$primaryMouseButton"
	sleep "$frequency"
done
