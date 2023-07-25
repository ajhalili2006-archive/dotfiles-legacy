# Bootstraping/Onboarding a new Linux machine, VM or container

This onboarding page documents how do I bootstrap stuff for an new Linux machine/VM, whenever testing the changes to one of my configuration files, testing new changes to the bootstrapping script, or generally speaking replacing Windows with Linux. This is written so I can setup my future development environments more easily and to serves this document as an signle source to setup an Linux machine with my configuration without all the fuzz. After completing these steps, you can install additional tools and software as needed.

## Prerequisites

* Access to my Bitwarden vault for GitLab PAT AND Tailscale reusable authtoken on an Vaultwarden instance at Railway. Once email has been fixed, probably my phone with 2FA number used for Google OR Authy app and Telegram client of choice.
* An working browser, preferrly Firefox or Chromium.
* An desktop environment preinstalled, in case of Alpine/Arch/Gentoo-based distros, proceed with Xfce4. Unless has atleast 4 GBs of memory on an amd64 machine, install GNOME or KDE instead.

### Pre-flight Check

* Check if the init system is systemd, and if not, check if we can swap init systems (or at least attempt to install systemd from source). This is required so we can install stuff using `snapd`. Using Flatpak is still being considered as alternative option.
* If you messing up with partitioning, especially Windows might go berserk when resizing, backup everything as much as possible. Ohterwise, we might be fucked.
* Check if Bash and/or Git is preinstalled while in live environment.
* Remember to note down the root password! You may also need to take down notes of your regular account password too, if sudo is configured.
* If you're trying an new distro (Arch, Gentoo, RHEL) or got an ChromeOS preinstalled and enabled devmode and Linux stuff, please install the tools one by one and note it down here in this document.
* Check if that distro either has GitHub CLI, GLab CLI and/or `hut` from the official package repos (or atleast community maintained ones). Otherwise, maybe opt to building from source or use prebuilt binaries from GitHub/GitLab/SourceHut Releases.

## Per-Distro/Platform Docs

Remember that Git, among other things will be installed during the bootsrap script runtime, although you need Bash installed first.

### Termux

> **:warning: Termux is only available for Android 7 to 9 on F-roid due to compatibility reasons!** Things start to blur once you upgrade to Android 10 or above, as more restrictions have been implemented, see ISSUE-TODO-LINK.

Right after the post app installation stuff are done, run this:

```bash
pkg add curl wget git
```

### Debian, Ubuntu and friends

Bash, GNU coreutils and curl/wget is pre-installed, but you may need to manually upgrade to their latest versions from the backports, especially if they're too far from the latest release.

As an final check before proceeding, install gnupg and friends before running the bootstrap script:

```sh
# they'll be also installed if you don't do this
sudo apt install gnupg gnupg-agent dirmgr --yes
```

## Alpine Linux

Bash, GNU core utilities, `sudo` and Git isn't installed by default. An of course, because Alpine Linux is musl-based lightweight distro, there's no manpages pre-installed. Run the following commands as root after rebooting from install media.

```sh
# Assuming we're root, install them first. Of course, don't forget nano because vim is diffcult to use.
apk add bash git coreutils sudo nano procs

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

# better yet, tag 'em instead
@edge http://nl.alpinelinux.org/alpine/edge/main
@edgecommunity http://nl.alpinelinux.org/alpine/edge/community
@testing http://nl.alpinelinux.org/alpine/edge/testing
```

Now, run `apk update` followed by `apk upgrade` to update all packages to their latest versions in the `edge` branch. If chose to tag them instead,
you need to `apk add bash@edge git@edge curl@edge coreutils@edge` instead.

### Gitpod?

~~Currently unsupported yet, but we can setup an meta-workspace with my dotfiles stuff loaded too, in the future, probably.~~ This is currently planned to work on since Gitpod already added dotfiles support, but for now the system will symlinking everything from the dotfiles repo.

### WSL 2-specific back pain treatment for Tailscale

Since WSl 2 doesn't use systemd yet as init system, you need to run the Tailscale deamon as root on login (hint: `sudo tailscaled ` on other Windows Terminal app
for moore verbose life). You need to also disable IPv6 support first, because M$FT still not fixed the fucked-up WSL 2 networking BS:[^1]

```bash
# Omit sudo if you're signed in as root or replace it with ooas
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1; sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
```

[^1]: I read an article regarding this frm <https://www.hanselman.com/blog/using-tailscale-on-windows-to-network-more-easily-with-wsl2-and-visual-studio-code>, even through his blog is written in .NET.

## Post System Preparation/Wramup

* Run the bootstrap script as noted in the README. **Remember that Tailscale setup is still manual due to presence of ACL policies in `recaptime.org.github` tailnet.**
* After bootstrapping, run the `tailscale-provisioner` script, which requires Deno instealled. It'll prompt you for an Tailscale authtoken and select tags. You don't need to do this on Termux, assuming the Android app is installed. If already configured, you may need to add `--force` flag on it.
* Manually import GPG keys with `gpg --decrypt "$DOTFILES_HOME/secrets/pgp/personal.key.asc" | gpg --import`.

## Optionals

* Install Cloudflare tunnel and login. There's Tailscale, but if I don't brothered adding another device to the tailnet, we can setup da API instead.

