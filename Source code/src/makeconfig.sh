#!/bin/bash

# Check syntax
if [ -z "$1" ]; then
  echo "Syntax : $0 [client identifier]"
  exit
fi

KEY_DIR=%%CCDIR%%/keys
OUTPUT_DIR=%%CCDIR%%/files
BASE_CONFIG=%%CCDIR%%/base.conf

cat ${BASE_CONFIG} \
    <(echo -e '<ca>') \
    ${KEY_DIR}/ca.crt \
    <(echo -e '</ca>\n<cert>') \
    ${KEY_DIR}/${1}.crt \
    <(echo -e '</cert>\n<key>') \
    ${KEY_DIR}/${1}.key \
    <(echo -e '</key>\n<tls-auth>') \
    ${KEY_DIR}/ta.key \
    <(echo -e '</tls-auth>') \
    > ${OUTPUT_DIR}/${1}.ovpn

if ! [ $? -lt 1 ]; then
  echo "Error during config make"
  exit
fi

echo Configuration file generated : "${OUTPUT_DIR}/${1}.ovpn"
