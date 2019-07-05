#!/bin/bash

set -e

# prerequisites: ansible, git, curl
# usage:
# curl -s https://raw.githubusercontent.com/hleb-rubanau/ansible-role-docker/master/bootstrap.sh | /bin/bash

PLAYBOOK_DIR="./ansible-role-docker-install"
PLAYBOOK_FILE=docker-playbook.yml
mkdir -v $PLAYBOOK_DIR
cd $PLAYBOOK_DIR

cat > requirements.yml <<REQUIREMENTS
---
- src: https://github.com/hleb-rubanau/ansible-role-docker
  name: docker
REQUIREMENTS

cat > $PLAYBOOK_FILE << PLAYBOOK
---
- hosts: localhost
  roles:
    - docker
PLAYBOOK

set -x 
ansible-galaxy install -r requirements.yml --roles-path ./roles
set +x


cat <<USAGE
Minimal ansible playbook created. To install docker, run the following commands:

cd $PLAYBOOK_DIR
ansible-playbook -i localhost, $PLAYBOOK_FILE
USAGE

