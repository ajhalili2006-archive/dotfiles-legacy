# Andrei Jiroh's Personal Dotfiles
<!-- markdownlint-disable-file MD033 -->

This is the main portal to my personal configuration for Linux/macOS stuff. If you're
working at Recap Time Squad (formerly The Pins Team), see [our dotfiles][df-gl] (currently unmaintained and on old namespace).

[df-gl]: https://gitlab.com/MadeByThePinsHub/dotfiles

## Getting Started

While the clone URLs use GitLab SaaS as the canonical Git repository URL, you can still clone the repository from the following URLs:

* GitLab self-hosted instances: `https://mau.dev/ajhalili2006/dotfiles`
* SourceHut (official instance): `https://git.sr.ht/~ajhalili2006/dotfiles` (SSH: `git@git.sr.ht:~ajhalili2006/dotfiles)

To get started, run the bootstrap script which handles the repository cloning/pulling for you and then sets things up for you.

```sh
# Pro-tip: Install the essientials like Git and Doppler first!
# Using the essientials setup script will handle Homebrewing for you, among other software-related
# chores. Works on Debian-based distros and Alpine Linux.
$(command -v curl>>/dev/null && echo curl -o- || echo wget -q0-) https://ctrl-c.club/~ajhalili2006/bin/essientials-setup-dotfiles.sh

# Run the bootstrap script without Doppler
$(command -v curl>>/dev/null && echo curl -o- || echo wget -q0-) https://gitlab.com/ajhalili2006/dotfiles/raw/main/bootstrap | bash -
```

### Documentation

Available documentation for the on/offboarding processes I do for devices + other tidbits of the bootstrap script can be accessible through [the `docs` directory](./docs) and on [my personal wiki hosted on Miraheze](https://ajhalili2006.miraheze.org/wiki/Dotfiles).

## License and contributions

Code is licensed under [the MPL-2.0](LICENSE) license, while docs on my MediaWiki-powered wiki
uses [CC BY-SA 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/legalcode).

Patches are welcome, but technical support for forks is currently unavailable due to this repository
being used for personal day-to-day use.

<details>

<summary>Deprecated docs stashed here for archival purposes, might be removed later.</summary>

## Want to fork me owo?

> This section is outdated and will be revised in the future since I also have other stuff to do behind the scenes.

Follow the checklist below after forking to ensure no references to mine are found. **Remember that your fork, your problem.** It's up to you on how do you customize stuff. You can use [The Pins Team's dotfiles template][template] to start from our template.

[template]: https://github.com/MadeByThePinsHub/dotfiles-template

* [ ] Customize the `dotfiles-bootstrapper-script.sh` and `setup.sh` into your needs.
* [ ] Delete any existing dotfiles I made (e.g. `gitconfig/*`, `bashrc/*` excluding `aliases` and `worthwhile-functions`, etc.) and do `bin/backup-dotfiles`. That script will move your current config into your `.dotfiles` local repo and do soft links.
* [ ] Edit `bin/fix-wrong-emails#L6-7` to use your email instead of mine.
* [ ] Edit `bin/add-ssh-keys#L4` to use your SSH key in `~/.ssh` directory.
* [ ] Want to backup your worst secrets AKA SSH and PGP keys (and some Pyrgoram session files?) Use my `bin/init-secrets-dir` script to setup an `secrets` directory. Don't forget to push this into an GitLab private repo.

</details>
