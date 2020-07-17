#!/bin/bash
SCRIPT=$(realpath $0)
SCRIPTPATH=$(dirname "$SCRIPT")
LIBPATH="%%LIBPATH%%"
SOURCEPATH="$SCRIPTPATH/src"
EASYRSADIR="%%EASYRSADIR%%"

# Includes
. "$LIBPATH"/stdio.sh
. "$LIBPATH"/string.sh

# Check syntax
if [ -z "$1" ]; then
  echo "Syntax : $0 [clientfile.req]"
  exit
fi

# Check if key file exists based on client name
FILE="$1"
if ! [ -f "$FILE" ]; then
  echo "File not found : $1"
  exit
fi
