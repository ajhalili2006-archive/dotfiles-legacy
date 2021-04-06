# Highlighting Files for Nano

Sometimes, highloghting can be a mess, especially if the included
`*.nanorc` files on `/usr/local/nano` (may varies on distro, especially
you're using the Termux Android app). So, I made this directory within
the `nanorc` category where I pull nanorc files from different sources.

## Where I Get them

* https://github.com/serialhex/nano-highlight

## How To Update

```bash
# Use the update-dotfiles to update nanorc files pulled
# from the Internet
update-dotfiles nanorc/highlighting
# Reading nanorc/config.yml...
# Cloning github:serialhex/nano-highlight...
# [OUTPUT GOES HERE]
# Copying nanorc files from local copy to nanorc/highlighting...
# [VERBOSE LOGS GOES HERE]
# Cleaning up...
# Done! The local Git repo status is:
# [git status output]
# To commit into your local dotfiles repo and sync to other machines
# run the following command:
#        git commit --signoff --gpg-sign && git push
```
