#!/bin/bash
mkdir pdfencrypt
git clone https://github.com/openwall/john
cd john/src
sudo apt-get update -y
sudo apt install libssl-dev
./configure && make
cd ..
cd ./run
export PATH=$PATH:./