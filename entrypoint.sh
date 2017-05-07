#!/bin/bash

USER_NAME=${USER_NAME:-user}
USER_ID=${USER_ID:-1000}
GROUP_ID=${GROUP_ID:-1000}
GROUP_NAME=${GROUP_NAME:-local}

echo "Starting as user ${USER_NAME} with uid $USER_ID and gid ${GROUP_ID}"
groupadd -o -g ${GROUP_ID} ${GROUP_NAME}
useradd --shell /bin/bash -u ${USER_ID} -g ${GROUP_ID} -o -m ${USER_NAME}
export HOME=/home/${USER_NAME}

cd ${HOME}

exec /usr/local/bin/gosu ${USER_NAME} "$@"
