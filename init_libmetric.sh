#!/bin/bash



#!/bin/bash

git clone https://github.com/cznewt/python-libmetric.git
sudo apt -y install librrd-dev
cd python-libmetric
virtualenv -p python venv
. venv/bin/activate
python setup.py install