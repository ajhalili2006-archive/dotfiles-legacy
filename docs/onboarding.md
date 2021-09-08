# Bootstraping/Onboarding a new Linux machine, VM or container

This onboarding page documents how do I bootstrap stuff for an new Linux machine/VM, whenever testing the changes to one of my configuration files, testing new changes to the bootstrapping script, or generally speaking replacing Windows with Linux. This is written so I can setup my future development environments more easily and to serves this document as an signle source to setup an Linux machine with my configuration without all the fuzz. After completing these steps, you can install additional tools and software as needed.

## Prerequisites

* Access to my Bitwarden vault for GitLab PAT on an Vaultwarden instance at Railway. Once email has been fixed, probably my phone with 2FA number used for Google OR Authy app and Telegram client of choice.
* An working browser, preferrly Chrome or Firefox.
* An desktop environment preinstalled, in case of Alpine/Arch/Gentoo-based distros, proceed with Xfce4. Unless has atleast 4 GBs of memory on an amd64 machine, install GNOME or KDE instead.

### Pre-flight Check

* Check if the init system is systemd, and if not, check if we can swap init systems. This is required so we can install stuff using `snapd`. Using Flatpak is still being considered as alternative option.
* If you messing up with partitioning, especially Windows might go berserk when resizing, backup everything as much as possible. Ohterwise, we might be f\*\*ked.
* Check if Bash and/or Git is preinstalled while in live environment.
* Remember to note down the root password! You may also need to take down notes of your regular account password too, if sudo is configured.
* If you're trying an new distro (Arch, Gentoo, RHEL) or got an ChromeOS preinstalled and enabled devmode and Linux stuff, please install the tools one by one and note it down here in this document.

## Termux

TODO

## Debian, Ubuntu and friends

TODO

## Alpine Linux

Bash, GNU core utilities, `sudo` and Git isn't installed by default. An of course, because Alpine Linux is musl-based lightweight distro, there's no manpages pre-installed. Run the following commands as root after rebooting from install media.

```sh
# Assuming we're root, install them first. Of course, don't forget nano because vim is diffcult to use.
apk add bash git coreutils sudo nano

# todo: Install wget and curl too. You may insert Golang, Python and Node.js here if you want.
```

If we need the latest and greatest, we need to upgrade to unstable version AKA `edge`. As per the Alpine Linux docs, only procced at your own risk as things might break between builds. If so, change `/etc/apk/repositories` with these contents:

```sh
# Remeber to comment the stable repos...
#http://dl-cdn.alpinelinux.org/alpine/v3.14/main
#http://dl-cdn.alpinelinux.org/alpine/v3.14/community
# ...and uncomment the edge ones (add them if these entries don't exist)
http://dl-cdn.alpinelinux.org/alpine/edge/main
http://dl-cdn.alpinelinux.org/alpine/edge/community
```

Now, run `apk update` followed by `apk upgrade` to update all packages to their latest versions in the `edge` branch.

Finally, follow the bootstrapping process of the dotfiles in the root README, which, as usual:

* export both the GitLab SaaS username and password with `export GITLAB_LOGIN=ajhalili2006 GITLAB_TOKEN=pat-from-bw-vault`
* run the main script with `curl -fsSL https://ajhalili2006.gitlab.io/linux-bootstrap.sh | bash -`
* optionally run the post-setup script to add my package signing key for Alpine, GPG keys, and probably my KeexPass stuff with `./tools/post-setup/alpine.sh`

## Gitpod?

Currently unsupported yet, please see ISSUE-LINK-TODO.
