#!/bin/bash

sudo apt-get install -y \
    virtualenv \
    python3-virtualenv \
    python3-pip

if test -d jsonnet-utils; then
    echo "jsonnet-utils exists, skipping."
else
    git clone https://github.com/cznewt/jsonnet-utils.git
    cd jsonnet-utils
    virtualenv -p python3 venv
    . venv/bin/activate
    pip3 install -r requirements.txt
    pip3 install pyyaml
    pip3 install cookiecutter
    python setup.py install
    cd ..
fi
