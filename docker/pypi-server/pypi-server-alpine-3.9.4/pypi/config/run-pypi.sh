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


#mkdir /root/.ssh/
#echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
#chmod 600 /root/.ssh/id_rsa

#RUN touch /root/.ssh/known_hosts
#RUN ssh-keyscan XXX >> /root/.ssh/known_hosts


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

# ************************
#  CONFIG VIRTUALENV
# ************************

echo
echo "*** CONFIG VIRTUALENV ***"


echo
echo "* Install virtualenv"
echo

pip3 install virtualenv

which virtualenv

echo
echo "* Create Python packages folder"
echo

mkdir ~/python-environment
cd ~/python-environment

echo
echo "* Create virtualenv: venv"
echo

#virtualenv -p python3 venv
virtualenv venv

source venv/bin/activate

/root/python-environment/venv/bin/python -m pip install --upgrade pip


# ************************
#  CONFIG OTHER DEPENDENCIES
# ************************

echo
echo "*** CONFIG OTHER DEPENDENCIES ***"

OTHER_DEPENDENCIES='setuptools wheel'

echo
echo "* Install other dependencies : ${OTHER_DEPENDENCIES}"
echo

pip3 install $OTHER_DEPENDENCIES


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