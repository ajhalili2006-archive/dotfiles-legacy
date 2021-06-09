# My Personal Dotfiles

Personal configuration for Linux/macOS stuff. If you're
working at The Pins Team, see [our dotfiles][df-gl].

[df-gl]: https://gitlab.com/MadeByThePinsHub/dotfiles

## Getting Started

### Using the bootstraper script without cloning

```sh
## configure required variables
export GITLAB_LOGIN=AndreiJirohHaliliDev2006
export GITLAB_TOKEN=<my-gitlab1dotcom-PAT>

## Run the bootstrap script
$(command -v curl>>/dev/null && echo curl -o- || echo wget -q0-) https://raw.githubusercontent.com/AndreiJirohHaliliDev2006/dotfiles/main/bootstrap | bash -

## Done?
unset GITLAB_TOKEN GITLAB_LOGIN
```

### With Cloning the Repo

```sh
# assuming git is installed
git clone https://github.com/AndreiJirohHaliliDev2006/dotfiles $HOME/.dotfiles
cd $HOME/.dotfiles

# no need for exporting my PAT before running this
./bootstrap --flags-over-here --and-this-one stuff

# you may optionally run the bootstrapper script if you want
GITLAB_LOGIN=AndreiJirohHaliliDev2006 GITLAB_TOKEN=<my-gitlab-saas-pat> ./bootstrap --flags-over here
```

## Want to fork me owo?

Follow the checklist below after forking to ensure no references to mine are found. **Remember that your fork, your problem.** It's up to you on how do you customize stuff. You can use [The Pins Team's dotfiles template][template] to start from our template.

[template]: https://github.com/MadeByThePinsHub/dotfiles-template

* [ ] Customize the `dotfiles-bootstrapper-script.sh` and `setup.sh` into your needs.
* [ ] Delete any existing dotfiles I made (e.g. `gitconfig/*`, `bashrc/*` excluding `aliases` and `worthwhile-functions`, etc.) and do `bin/backup-dotfiles`. That script will move your current config into your `.dotfiles` local repo and do soft links.
* [ ] Edit `bin/fix-wrong-emails#L6-7` to use your email instead of mine.
* [ ] Edit `bin/add-ssh-keys#L4` to use your SSH key in `~/.ssh` directory.
* [ ] Want to backup your worst secrets AKA SSH and PGP keys (and some Pyrgoram session files?) Use my `bin/init-secrets-dir` script to setup an `secrets` directory. Don't forget to push this into an GitLab private repo.
