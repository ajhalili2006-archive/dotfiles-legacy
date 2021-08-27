# Tests for Bootstrap Scripts

## What is THIS?!?

Shit may happen sometimes, especially if you ever write Bash script for `bootstrap` without using ShellCheck or shfmt. These tests usually
happen after pushing changes of bootstrap script to GitHub, probably switch to GitLab CI for the image builds. What it does is just
run the bootstrap script from an local copy within the Docker image.

## Why?

I want to test my bootstrap script against every possible edge cases, including GitHub Codespaces and Gitpod, but I cannot
cover all cases, so this will be in best effort basis.
