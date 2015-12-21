#!/bin/bash

apt-get update
apt-get -y install git-core curl bzip2 || exit 1
apt-get clean -y

if [ "$1" -eq "2" ]; then
	echo "Installing anaconda with python2"
	curl -L http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh > /tmp/miniconda.sh
else
	echo "Installing anaconda with python3"
	curl -L http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh > /tmp/miniconda.sh
fi

bash /tmp/miniconda.sh -p /opt/conda -b || exit 1
rm /tmp/miniconda.sh

echo "Force installing matplotlib version without requirements"
MATPLOTLIB_VERSION=$(cat /tmp/req.txt ; grep 'matplotlib')
if [ ! -z "$MATPLOTLIB_VERSION" ]; then
	# we need matplotlib
	MATPLOTLIB_DEPENDENCIES=$(conda install --dry-run --json matplotlib | python -c '
from __future__ import print_function
import sys,json
arr = json.load(sys.stdin)["actions"]["EXTRACT"]
arr = [v.split("-")[0] for v in arr]
arr = [v for v in arr if v.find("qt") == -1 and v != "matplotlib"]
print(" ".join(arr))')
	conda install -y --no-deps $MATPLOTLIB_VERSION
fi

echo "Installing base packages from req.txt... "
conda install -y -f /tmp/req.txt

echo "Setting up matplotlib dependencies minus qt"
if [ ! -z "$MATPLOTLIB_VERSION" ]; then
	#Setup matplotlib without qt:
	echo "Dependencies found : $MATPLOTLIB_DEPENDENCIES"
	conda install -y $MATPLOTLIB_DEPENDENCIES
fi