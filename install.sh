#!/bin/bash
INSTALL_PATH="bin"
ALIAS="\\nalias glog=\"bash ~/bin/gym-logger.sh\" \\n"
FILENAME="gym-logger.sh"

cd $HOME

if [ ! "$(ls -A "${INSTALL_PATH}")" ]; then
    echo "Path doesnt exists"
    mkdir "${INSTALL_PATH}"
    cd "${INSTALL_PATH}"

    if [ "$(ls -A "${FILENAME}")" ]; then
        echo "File exists. Fetching again."
    fi

fi

curl https://raw.githubusercontent.com/Irungaray/gym-logger/main/gym-logger.sh -s -o ${FILENAME}

command printf "${ALIAS}" >> "${HOME}/.zshrc"
command printf "${ALIAS}" >> "${HOME}/.bashrc"
