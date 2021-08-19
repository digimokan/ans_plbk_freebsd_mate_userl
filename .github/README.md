# ans_plbk_freebsd_mate_userl

Ansible playbook to configure FreeBSD with the MATE DE, for one user.

[![Release](https://img.shields.io/github/release/digimokan/ans_plbk_freebsd_mate_userl.svg?label=release)](https://github.com/digimokan/ans_plbk_freebsd_mate_userl/releases/latest "Latest Release Notes")
[![License](https://img.shields.io/badge/license-MIT-blue.svg?label=license)](LICENSE.txt "Project License")

## Table Of Contents

* [Purpose](#purpose)
* [Hardware Requirements](#hardware-requirements)
* [Quick Start](#quick-start)
    * [Create FreeBSD ISO](#create-freebsd-iso)
    * [Configure Workstation](#configure-workstation)
    * [Update Workstation](#update-workstation)
* [Vault Variables](#vault-variables)
* [Source Code Layout](#source-code-layout)
* [Contributing](#contributing)

## Purpose

Set up a workstation/desktop-PC for normal daily use:

* Configure the MATE desktop environment.
* Configure a basic set of applications.

## Hardware Requirements

* An empty/formattable USB stick (to write the FreeBSD iso to).
* A workstation PC with with an empty/formattable hard drive (or two empty hard
  drives, for a mirrored installation).

## Quick Start

### Create FreeBSD ISO

1. Write the FreeBSD installer image to a USB stick, as described in
   [FreeBSD Handbook Installation Chapter](https://docs.freebsd.org/en/books/handbook/bsdinstall/#bsdinstall-pre).

2. Insert the USB stick into the target workstation PC, and boot from the
   FreeBSD installer image.

2. Follow the guided installation. Select these options:

    * zfs filesystem.




3. Remove the USB stick, and reboot the PC to the new installation.

### Configure Workstation

1. Install ansible at the root prompt:

   ```shell
   $ pkg install sysutils/ansible
   ```

2. Clone project into a local project directory:

   ```shell
   $ git clone https://github.com/digimokan/ans_plbk_freebsd_mate_userl.git
   ```

3. Change to the local project directory:

   ```shell
   $ cd ans_plbk_freebsd_mate_userl
   ```

4. Ensure `vault_password.txt` has been created, as desribed in
   [Vault Variables](#vault-variables).

5. Run the [`configure.sh`](../configure.sh) script to configure the workstation.

   ```shell
   $ ./configure.sh
   ```

### Update Workstation

To update the workstation PC at a later time, use the `admin` user account, which
was set up during initial configuration.

1. Log in to the `admin` user account.

2. Change to the pre-provisioned project directory:

   ```shell
   $ cd ans_plbk_freebsd_mate_userl
   ```

3. Run the [`configure.sh`](../configure.sh) script to update the workstation.

   ```shell
   $ ./configure.sh
   ```

## Vault Variables

* The encrypted vault variables are stored in [`vault.yml`](../host_vars/vault.yml).

* Prior to encrypting or decrypting vault variables, the vault password string
  needs to be put into the `vault_password.txt` file
  ([at the root of this repo directory](#source-code-layout)).

* [`playbook.yml`](../playbook.yml) automatically uses the vault password file to
  decrypt vars in [`vault.yml`](../host_vars/vault.yml), via a setting in
  [`ansible.cfg`](../ansible.cfg).

* To create or replace an encrypted vault variable, use the string provided by:

   ```shell
   $ ansible-vault encrypt_string 'secret_var_value' --name 'secret_var_name'
   ```

* To decrypt and view a var from [vault.yml](../host_vars/vault.yml):

   ```shell
   $ ansible -i hosts localhost -m ansible.builtin.debug -a var="secret_var_name" -e "@host_vars/vault.yml"
   ```

## Source Code Layout

```
├─┬ ans_plbk_freebsd_mate_userl/
│ │
│ ├─┬ host_vars/
│ │ │
│ │ └── vault.yml         # encrypted vault variables used by playbook.yml
│ │
│ ├─┬ roles/
│ │ │
│ │ └── ext/              # external (third-party, downloaded) roles
│ │
│ ├── ansible.cfg         # play-wide Ansible meta-config
│ ├── configure.sh        # configures the workstation, post-installation
│ ├── hosts               # Ansible inventory (configured for local host)
│ ├── playbook.yml        # main Ansible playbook
│ ├── requirements.yml    # list of roles (on github/galaxy) to download
│ └── vault_password.txt  # password-string to encrypt and decrypt vault vars
│
```

## Contributing

* Feel free to report a bug or propose a feature by opening a new
  [Issue](https://github.com/digimokan/ans_plbk_freebsd_mate_userl/issues).
* Follow the project's [Contributing](CONTRIBUTING.md) guidelines.
* Respect the project's [Code Of Conduct](CODE_OF_CONDUCT.md).
