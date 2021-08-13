#!/bin/bash

set -e

# prerequisites: ansible, git, curl
# usage:
# curl -s https://raw.githubusercontent.com/hleb-rubanau/ansible-role-docker/master/bootstrap.sh | /bin/bash

PLAYBOOK_DIR=$(mktemp -d ansible-docker-bootstrap.XXX )
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

echo "Bootstrapping docker from $PLAYBOOK_DIR" 

set -x 
ansible-galaxy install -r requirements.yml --roles-path ./roles
ansible-playbook -i localhost, -c local $PLAYBOOK_FILE
rm -rv "$PLAYBOOK_DIR"
