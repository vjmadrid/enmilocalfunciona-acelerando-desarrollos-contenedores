#!/bin/bash

set -e

[[ "${DEBUG}" == "true" ]] && set -x

#[[ "${DEBUG}" == "true" ]] && set -o xtrace


# ***********************
#  CONFIG GENERAL
# ***********************

echo
echo "*** CONFIG GENERAL ***"

echo "* Linux version used"
echo

cat /etc/*release


# ***********************
#  CONFIG PYTHON
# ***********************

echo
echo "*** CONFIG PYTHON ***"

apk --update --no-cache add bash python3

if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi

echo
echo "* Python version used"
echo

python -V


# ************************
#  CONFIG PIP
# ************************

echo
echo "*** CONFIG PIP ***"

python3 -m ensurepip

rm -r /usr/lib/python*/ensurepip

pip3 install --no-cache --upgrade pip

if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

python -m pip install --upgrade pip

echo
echo "* Pip version used"
echo

pip3 -V

echo
echo "* Install virtualenv"
echo

pip3 install virtualenv

which virtualenv

mkdir ~/python-environment
cd ~/python-environment

echo
echo "* Create virtualenv: venv"
echo

virtualenv -p python3 venv

source venv/bin/activate

/root/python-environment/venv/bin/python -m pip install --upgrade pip

echo
echo "* Install other dependencies"
echo

pip3 install setuptools wheel


# ************************
#  CONFIG PYPI-SERVER
# ************************

echo
echo "*** CONFIG PYPI-SERVER ***"

pip3 install pypiserver

PACKAGE_FOLDER=/srv/packages
echo "[EVN] PACKAGE_FOLDER=${PACKAGE_FOLDER}"


rm -rf /tmp/* /var/cache/apk/*

echo
echo "*** START pypi-server ***"
echo "[START] pypi-server daemon starting"
pypi-server $PACKAGE_FOLDER || \
	{ echo "Failed to execute pypi-server"; exit 1; }