
#!/bin/bash

set -e

echo "*** CONFIG DEBUG ***"

[[ "${DEBUG}" == "true" ]] && set -x

#[[ "${DEBUG}" == "true" ]] && set -o xtrace


echo "*** CONFIG GENERAL ***"

echo "* Linux version used"
echo

cat /etc/*release

if [[ $1 == "-d" ]]; then
    echo "* Execute sleep"
    while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
    echo "* Execute bash"
    /bin/bash
fi
