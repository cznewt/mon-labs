#!/bin/bash

if test -f jsonnet-utils; then
    echo "jsonnet-utils exists, skipping."
else
    git clone https://github.com/cznewt/jsonnet-utils.git
    cd jsonnet-utils
    virtualenv -p python3 venv
    . venv/bin/activate
    pip install -r requirements.txt
    pip install pyyaml
    python setup.py install
    cd ..
fi
