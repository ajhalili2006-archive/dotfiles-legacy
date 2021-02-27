# My Personal Dotfiles

Personal configuration for Linux/macOS stuff. If you're working at The Pins Team, see [our dotfiles](https://gitlab.com/MadeByThePinsHub/dotfiles).

## Getting Started

### Using the bootstraper script

```sh
## configure required variables
export GH_USERNAME=AndreiJirohHaliliDev2006
export GH_PAT=<my-gitlabdotcom-PAT>

## Run the bootstrap script
$(command -v curl>>/dev/null && echo curl -o-||wget -q0-) https://raw.githubusercontent.com/AndreiJirohHaliliDev2006/.dotfiles/main/bootstrap-linux.sh | bash -

## Done?
unset GH_USERNAME GH_PAT
```

## Want to fork me owo?

Follow the checklist below after forking to ensure no references to mine are found. **Remember that your fork, your problem.** It's up to you on how do you customize stuff.

* [ ] Customize the `bootstrap-linux.sh` into your needs.
* [ ] Delete any existing dotfiles I made (e.g. `*.gitconfig`, `*.bashrc`, etc.) and do `bin/backup-dotfiles`. That script will move your current config into your `.dotfiles` local repo and do soft links.
* [ ] Edit `bin/fix-wrong-emails#L4` to use your email instead of mine.
* [ ] Edit `bin/add-ssh-keys#L4` to use your SSH key in `~/.ssh` directory.
* [ ] Want to backup your worst secrets AKA SSH and PGP keys (and some Pyrgoram session files?) Use my `bin/init-secrets-dir` script to setup an `secrets` directory. Don't forget to push this into an GitLab private repo.
