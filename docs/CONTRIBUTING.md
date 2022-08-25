# Contributing to my dotfiles

## Development

Usually Andrei Jiroh clone the dotfiles repository in `~/.dotfiles` directory, but feel free
to customize the clone location. The rest of this section contains the TL;DR version of the
contribution process, plus additional information about each parts.

```sh
## easy path: use Gitpod and GLab CLI ##
xdg-open "https://gitpod.io/#https://gitlab.com/ajhalili2006/dotfiles"
# ssh to the workspace using an owner token - https://www.gitpod.io/docs/ides-and-editors/command-line#access-token-ssh
ssh ajhalili2006-dotfiles-abcdefg123456#ownerToken@ajhalili2006-dotfiles-abcdefg123456.ssh.ws-us62.gitpod.io
# use GLab CLI to fork the repo and configure remotes
glab repo fork --remote=true # assuming GITLAB_TOKEN is set for GitLab SaaS
# do your own homework here and push to your personal branch
git switch -c username/some-descriptive-name-here
nano bootstrap config/bashrc/aliases # or <vi|emacs> bootstrap config/bashrc/aliases
shellcheck --severity=warning bootstrap config/bashrc/aliases # run the shell linter for issues
git commit --signoff # commit with Signed-off-by trailer for DCO
git push origin username/some-descriptive-name-here # publish your changes before submiting patches
glab mr create -R https://gitlab.com/ajhalili2006/dotfiles -b main # create a merge request

## the mailing list way: use sourcehut mirror ##
docker run --rm -v $HOME:/home/gildedguy quay.io/ajhalili2006/docker-alpine-env
mkdir ~/git-projects/ajhalili2006
git clone https://git.sr.ht/~ajhalili2006/dotfiles ~/git-projects/ajhalili2006/dotfiles && cd ~/git-projects/ajhalili2006/dotfiles
# do your own homework here and (optionally) push to your personal branch
git switch -c username/some-descriptive-name-here
nano bootstrap config/bashrc/aliases # or <vi|emacs> bootstrap config/bashrc/aliases
shellcheck --severity=warning bootstrap config/bashrc/aliases # run the shell linter for issues
git commit --signoff # commit with Signed-off-by trailer for DCO
git remote add username-srht git@git.sr.ht:~username/ajhalili2006-dotfiles-patches && git push username-srht username/some-descriptive-name-here # if it doesn't exist, creates a repo on push
# configure your local copy, per https://git-send-email.io/#
git config sendemail.to "~ajhalili2006/public-inbox@lists.sr.ht"
git config format.subjectprefix "PATCH dotfiles" # or sandbox-dotfiles for sandbox/main branch
```

## Submitting patches

### DCO and CLA

Recap Time Squad's CLA do not apply in this project, although I might use Eclipse Contributor Agreement to legally codify DCO in case of corporate contributions.

### Sending patches via email

If you prefer to send patches via email, please set your local copy of this repository with
the following configuration for `git send-email`:

```sh
git config sendemail.to "~ajhalili2006/public-inbox@lists.sr.ht"
git config format.subjectprefix "PATCH dotfiles" # or sandbox-dotfiles for sandbox/main branch
```

Please note that I'll not accept patches that sent to my personal email address/es instead of
through the public inbox mailing list.
