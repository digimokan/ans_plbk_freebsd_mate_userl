#!/bin/sh
# Purpose: update ansible to latest python version on FreeBSD

# FreeBSD ansible won't auto-update to latest pyXX-ansible version, so do this
echo "Installing the latest 'pyXX-ansible' package...."
pkg install --yes sysutils/ansible

# NOTE: py-psutil is required for dconf module for MATE
#   - see https://docs.ansible.com/ansible/latest/collections/community/general/dconf_module.html#notes
echo "Installing the latest 'py-psutil' package...."
pkg install --yes sysutils/py-psutil

