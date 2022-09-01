#!/bin/bash

current=$PWD

curr_file_path="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
curr_root_path="$(dirname "${curr_file_path}")"
venv_path="${curr_root_path}/.venv"
cd ${curr_root_path}


if [ $(dpkg-query -W -f='${Status}' nano 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "virtualenv not installed. Installing it..."
  sudo apt-get install virtualenv -y
fi

if [[ ! -f ${venv_path} ]]; then
    echo "Creating virtualenv folder"
    virtualenv -p /usr/bin/python3.8 ${venv_path}
fi
echo "Activating virtualenv and installing requirements"
source ${venv_path}/bin/activate && pip install -r ${curr_root_path}/requirements.txt

echo """
Start working on the virtualenv folder with:

cd ${curr_root_path}
source ${venv_path}/bin/activate 

When finished, type "deactivate" or remove the .venv folder
"""

cd $current