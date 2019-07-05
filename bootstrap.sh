#!/bin/bash

set -e

# prerequisites: ansible, git, curl

PLAYBOOK_DIR="./ansible-role-docker-install"
mkdir -v $PLAYBOOK_DIR
cd $PLAYBOOK_DIR

cat > requirements.yml <<REQUIREMENTS
---
- src: https://github.com/hleb-rubanau/ansible-role-docker
  name: docker
REQUIREMENTS

cat > playbook.yml << PLAYBOOK
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
ansible-playbook -i localhost, docker-playbok.yml
USAGE

