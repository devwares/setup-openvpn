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

# Check if file exists
FILE="$1"
if ! [ -f "$FILE" ]; then
  echo "File not found : $1"
  exit
fi

clientname="`filenamewithoutext "$1"`"

cd "$EASYRSADIR"
./easyrsa import-req "$1" $clientname
if ! [ $? -lt 1 ]; then
  echo "Error during import process"
  exit
fi

./easyrsa sign-req client $clientname
if ! [ $? -lt 1 ]; then
  echo "Error during signing process"
  exit
fi

echo File issued : "$EASYRSADIR/pki/issued/$clientname.crt"
echo Now transfer it to the server then make a client config
