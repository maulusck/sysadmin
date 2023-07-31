#!/bin/sh
set -e

OUT_DIR="/root/.ssh"
OUT_KEY="${OUT_DIR}/id_sysbak_rsa"

mkdir -p -m 700 $OUT_DIR
# generate RSA4096, nopass SSH key
ssh-keygen -q -t rsa -b 4096 -N '' -f $OUT_KEY
echo "Done."
