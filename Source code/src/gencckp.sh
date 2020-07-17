#!/bin/bash
SCRIPT=$(realpath $0)
SCRIPTPATH=$(dirname "$SCRIPT")
LIBPATH="%%LIBPATH%%"
SOURCEPATH="$SCRIPTPATH/src"
CCDIR="%%CCDIR%%"
EASYRSADIR="%%EASYRSADIR%%"

# Includes
. "$LIBPATH"/stdio.sh
. "$LIBPATH"/string.sh

# Check syntax
if [ -z "$1" ]; then
  echo "Syntax : $0 [client]"
  exit
fi

cd "$EASYRSADIR"
./easyrsa gen-req $1 nopass
cp -f "$EASYRSADIR/pki/private/$1.key" "$CCDIR/keys"
echo Please sign "$EASYRSADIR/pki/reqs/$1.req" on the CA machine.
echo Then transfer the issued .crt file into "$EASYRSADIR"
