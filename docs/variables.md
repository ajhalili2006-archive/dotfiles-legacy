# Supprted variables for bootstrap script

This list is non-exhastive and may be out of date. The bootstrap script's source code might contains them all.

| Variable name | description | Type |
| --- | --- | --- |
| `USE_CODE_SERVER` | Installs code-server to use VS Code in a web browser. | Bootstrap flag |
| `USE_GH_SECRETS_MIRROR` | Use GitHub mirror for the dotfiles-secrets repo, requires the GitHub CLI to be installed for this process. | Botstrap flag |
| `USE_NVM` | Use Node Version Manager to install Node.js instead of NodeSource's way. May require you to install build tools if nvm went to installing from source, especially if you're on i386. |
| `DOTFILES_OS_NAME` | OS detection mechanisms for various automated steps in the bootstrap script. | OS detection system |
| `GOOGLE_CLOUD_SHELL` | Used to detect Cloud Shell environment | OS detectio system
| `GITLAB_LOGIN` | GitLab SaaS username for cloning the secrets repo, for validation purposes only. | Bootstrap flag |
| `GITLAB_TOKEN` | GitLab SaaS personal access token for cloning the secrets repo, not needed if `USE_GH_SECRETS_MIRROR` is being used | Bootstrap flag |
| `SKIP_CONFIG_LINKING` | Skips the process of symlinking config files to their destinations | Bootstrap flag |
| `SKIP_DEPENDENCY_INSTAL` | Skips installation of ShellCheck and other tooling and stuff | Bootstrap flag |
