#!/bin/bash

git clone https://github.com/cznewt/python-libmetric.git
cd python-libmetric
virtualenv -p python venv
. venv/bin/activate
python setup.py install
