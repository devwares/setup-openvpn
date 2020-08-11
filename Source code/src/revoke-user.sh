#!/bin/bash

SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
EASYRSADIR="%%EASYRSADIR%%"

# Check syntax
if [ -z "$1" ]; then
  echo "Syntax : $0 [username]"
  exit
fi

cd $EASYRSADIR
./easyrsa revoke $1
if ! [ $? -lt 1 ]; then
  echo "Error during revoke process"
  exit
fi

./easyrsa gen-crl
if ! [ $? -lt 1 ]; then
  echo "Error during CRL file generation"
  exit
fi

echo File issued : "$EASYRSADIR/pki/crl.pem"
echo Transfer file to directory /etc/openvpn on the server then reload openvpn service
