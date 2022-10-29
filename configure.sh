#!/bin/sh

# FreeBSD ansible won't auto-update to latest pyXX-ansible version, so do this
echo "Installing the latest 'pyXX-ansible' package...."
pkg install --yes sysutils/ansible

# NOTE: py-psutil is required for dconf module for MATE
#   - see https://docs.ansible.com/ansible/latest/collections/community/general/dconf_module.html#notes
echo "Installing the latest 'py-psutil' package...."
pkg install --yes sysutils/py-psutil

# use ansible-galaxy cmd to download roles & collections from github/galaxy/etc
ansible-galaxy install \
  --role-file requirements.yml \
  --roles-path ./roles/ext \
  --force-with-deps \
  || exit 1

# run the playbook, passing through args to ansible-playbook cmd
ansible-playbook -i hosts --ask-become-pass --become-method=su "${@}" playbook.yml

